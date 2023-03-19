import glob
from os import path

import yaml
import pandas as pd
from snakemake.remote import FTP
from snakemake.utils import validate

ftp = FTP.RemoteProvider()

validate(config, schema="../schemas/config.schema.yaml")
samples = pd.read_csv(config["samples"], sep="\t", dtype=str, comment="#").set_index("sample_name", drop=False)
samples.index.names = ["sample_id"]


def drop_unique_cols(df):
    singular_cols = df.nunique().loc[(df.nunique().values <= 1)].index
    return df.drop(singular_cols, axis=1)


samples = drop_unique_cols(samples)
validate(samples, schema="../schemas/samples.schema.yaml")

units = pd.read_csv(config["units"], dtype=str, sep="\t", comment="#").set_index(
    ["sample_name", "unit_name"], drop=False
)
units.index.names = ["sample_id", "unit_id"]
units.index = units.index.set_levels([i.astype(str) for i in units.index.levels])  # enforce str in index
validate(units, schema="../schemas/units.schema.yaml")

# Setup groups
groups = samples["group"].unique()
group_annotation = pd.DataFrame({"group": groups}).set_index("group")

# construct genome name
datatype = "dna"
species = config["resources"]["ref"]["species"]
build = config["resources"]["ref"]["build"]
release = config["resources"]["ref"]["release"]
genome_name = f"genome.{datatype}.{species}.{build}.{release}"
genome_prefix = f"resources/{genome_name}"
genome = f"{genome_prefix}.fasta"
genome_fai = f"{genome}.fai"
genome_dict = f"{genome_prefix}.dict"


def _group_or_sample(row):
    group = row.get("group", None)
    if pd.isnull(group):
        return row["sample_name"]
    return group


def get_final_output(wildcards):
    final_output = expand(
        "results/star_se_output/{sample}/Log.final.out",
        sample=samples["sample_name"],
    )
    return final_output


def get_cutadapt_input(wildcards):
    unit = units.loc[wildcards.sample].loc[wildcards.unit]

    if pd.isna(unit["fq1"]):
        return get_sra_reads(wildcards.sample, wildcards.unit, ["1", "2"])

    if unit["fq1"].endswith("gz"):
        ending = ".gz"
    else:
        ending = ""

    if pd.isna(unit["fq2"]):
        # single end local sample
        return "pipe/cutadapt/{S}/{U}.fq1.fastq{E}".format(S=unit.sample_name, U=unit.unit_name, E=ending)
    else:
        # paired end local sample
        return expand(
            "pipe/cutadapt/{S}/{U}.{{read}}.fastq{E}".format(S=unit.sample_name, U=unit.unit_name, E=ending),
            read=["fq1", "fq2"],
        )


def get_sra_reads(sample, unit, fq):
    unit = units.loc[sample].loc[unit]
    # SRA sample (always paired-end for now)
    accession = unit["sra"]
    return expand("sra/{accession}_{read}.fastq.gz", accession=accession, read=fq)


def get_raw_reads(sample, unit, fq):
    pattern = units.loc[sample].loc[unit, fq]
    if pd.isna(pattern):
        assert fq.startswith("fq")
        fq = fq[len("fq") :]
        return get_sra_reads(sample, unit, fq)

    if "*" in pattern:
        files = sorted(glob.glob(units.loc[sample].loc[unit, fq]))
        if not files:
            raise ValueError(
                "No raw fastq files found for unit pattern {} (sample {}). "
                "Please check the your sample sheet.".format(unit, sample)
            )
    else:
        files = [pattern]
    return files


def get_cutadapt_pipe_input(wildcards):
    return get_raw_reads(wildcards.sample, wildcards.unit, wildcards.fq)


def get_fastqc_input(wildcards):
    return get_raw_reads(wildcards.sample, wildcards.unit, wildcards.fq)[0]


def get_cutadapt_adapters(wildcards):
    unit = units.loc[wildcards.sample].loc[wildcards.unit]
    try:
        adapters = unit["adapters"]
        if isinstance(adapters, str):
            return adapters
        return ""
    except KeyError:
        return ""


def is_paired_end(sample):
    sample_units = units.loc[sample]
    fq2_null = sample_units["fq2"].isnull()
    sra_null = sample_units["sra"].isnull()
    paired = ~fq2_null | ~sra_null
    all_paired = paired.all()
    all_single = (~paired).all()
    assert all_single or all_paired, "invalid units for sample {}, must be all paired end or all single end".format(
        sample
    )
    return all_paired


def group_is_paired_end(group):
    samples = get_group_samples(group)
    return all([is_paired_end(sample) for sample in samples])


def get_group_aliases(group):
    return samples.loc[samples["group"] == group]["alias"]


def get_group_samples(group):
    return samples.loc[samples["group"] == group]["sample_name"]


def get_group_sample_aliases(wildcards, controls=True):
    if controls:
        return samples.loc[samples["group"] == wildcards.group]["alias"]
    return samples.loc[(samples["group"] == wildcards.group) & (samples["control"] == "no")]["alias"]


# def get_trimming_input(wildcards):
#     if is_activated("remove_duplicates"):
#         return "results/dedup/{}.bam".format(wildcards.sample)
#     else:
#         return "results/mapped/{}.bam".format(wildcards.sample)


def _get_batch_info(wildcards):
    for group in get_report_batch(wildcards):
        for sample, bam in get_group_bams_report(group):
            yield sample, bam, group


def get_batch_bams(wildcards):
    return (bam for _, bam, _ in _get_batch_info(wildcards))


def get_report_bam_params(wildcards, input):
    return [
        "{group}:{sample}={bam}".format(group=group, sample=sample, bam=bam)
        for (sample, _, group), bam in zip(_get_batch_info(wildcards), input.bams)
    ]


def get_resource(name):
    return workflow.source_path("../resources/{}".format(name))


def get_read_group(wildcards):
    """Denote sample name and platform in read group."""
    return r"-R '@RG\tID:{sample}\tSM:{sample}\tPL:{platform}'".format(
        sample=wildcards.sample, platform=samples.loc[wildcards.sample, "platform"]
    )


def get_report_batch(wildcards):
    if wildcards.batch == "all":
        _groups = groups
    else:
        _groups = samples.loc[
            samples[config["report"]["stratify"]["by-column"]] == wildcards.batch,
            "group",
        ].unique()
    if not any(_groups):
        raise ValueError("No samples found. Is your sample sheet empty?")
    return _groups


# def get_scattered_calls(ext="bcf"):
#     def inner(wildcards):
#         return expand(
#             "results/calls/{{group}}.{caller}.{{scatteritem}}.{ext}",
#             caller=caller,
#             ext=ext,
#         )
#     return inner


# def get_merge_calls_input(ext="bcf"):
#     def inner(wildcards):
#         return expand(
#             "results/calls/{{group}}.{vartype}.{{event}}.fdr-controlled.{ext}",
#             ext=ext,
#             vartype=["SNV", "INS", "DEL", "MNV", "BND", "INV", "DUP", "REP"],
#         )
#     return inner


# def get_filter_targets(wildcards, input):
#     if input.predefined:
#         return " | bedtools intersect -a /dev/stdin -b {input.predefined} ".format(
#             input=input
#         )
#     else:
#         return ""
# caller = list(
#     filter(
#         None,
#         [
#             "freebayes" if is_activated("calling/freebayes") else None,
#             "delly" if is_activated("calling/delly") else None,
#         ],
#     )
# )


wildcard_constraints:
    group="|".join(groups),
    sample="|".join(samples["sample_name"]),


### USAGE of wc seems to be in lambda functions within snakemake rules, ex
# params:
#     primers=lambda wc, input: format_bowtie_primers(wc, input.primers),

# def get_fastqs(wc):
#     return expand(
#         "results/trimmed/{sample}/{unit}_{read}.fastq.gz",
#         unit=units.loc[wc.sample, "unit_name"],
#         sample=wc.sample,
#         read=wc.read,
#     )


def get_sample_alias(wildcards):
    return samples.loc[wildcards.sample, "alias"]


# def get_fastqc_results(wildcards):
#     group_samples = get_group_samples(wildcards.group)
#     sample_units = units.loc[group_samples]
#     sra_units = pd.isna(sample_units["fq1"])
#     paired_end_units = sra_units | ~pd.isna(sample_units["fq2"])

#     # fastqc
#     pattern = "results/qc/fastqc/{unit.sample_name}/{unit.unit_name}.{fq}_fastqc.zip"
#     yield from expand(pattern, unit=sample_units.itertuples(), fq="fq1")
#     yield from expand(pattern, unit=sample_units[paired_end_units].itertuples(), fq="fq2")

#     # cutadapt
#     pattern = "results/trimmed/{unit.sample_name}/{unit.unit_name}.{mode}.qc.txt"
#     yield from expand(pattern, unit=sample_units[paired_end_units].itertuples(), mode="paired")
#     yield from expand(pattern, unit=sample_units[~paired_end_units].itertuples(), mode="single")

#     # samtools idxstats
#     yield from expand("results/qc/{sample}.bam.idxstats", sample=group_samples)

#     # samtools stats
#     yield from expand("results/qc/{sample}.bam.stats", sample=group_samples)


def is_activated(config_element):
    return config_element["activate"] in {"true", "True"}


def get_model(wildcards):
    if wildcards.model == "all":
        return {"full": None}
    return config["diffexp"]["models"][wildcards.model]


def is_single_end(sample, unit):
    """Determine whether unit is single-end."""
    fq2_not_present = pd.isnull(units.loc[(sample, unit), "fq2"])
    return fq2_not_present


def get_fastqs(wildcards):
    """Get raw FASTQ files from unit sheet."""
    # TODO Upgrade to parse common remote prefixes as well as local (e.g. s3://, https://)
    if is_single_end(wildcards.sample, wildcards.unit):
        return units.loc[(wildcards.sample, wildcards.unit), "fq1"]
    else:
        u = units.loc[(wildcards.sample, wildcards.unit), ["fq1", "fq2"]].dropna()
        return [f"{u.fq1}", f"{u.fq2}"]


def get_trimmed(wildcards):
    if not is_single_end(**wildcards):
        # paired-end sample
        return expand(
            "results/trimmed/{sample}-{unit}.{group}.fastq.gz",
            group=[1, 2],
            **wildcards,
        )
    # single end sample
    return expand("results/trimmed/{sample}-{unit}.fastq.gz", **wildcards)
