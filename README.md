# Snakemake workflow: rna-seq-kallisto-sleuth

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4675671.svg)](https://doi.org/10.5281/zenodo.4675671)
[![Snakemake](https://img.shields.io/badge/snakemake-≥6.3.0-brightgreen.svg)](https://snakemake.github.io)

A Snakemake workflow for differential expression analysis of RNA-seq data with [Kallisto](https://pachterlab.github.io/kallisto) and [Sleuth](https://pachterlab.github.io/sleuth).


## Usage

The usage of this workflow is described in the [Snakemake Workflow Catalog](https://snakemake.github.io/snakemake-workflow-catalog/?usage=snakemake-workflows%2Frna-seq-kallisto-sleuth).

If you use this workflow in a paper, don't forget to give credits to the authors by citing the URL of this (original) repository and its DOI (see above).

## Development Test Setup

```bash
poetry install --with dev
# Format the Snakefile
poetry run snakefmt workflow/Snakefile
# Format the rules
poetry run snakefmt workflow/rules/
# Format the scripts
poetry run snakefmt workflow/scripts
# Run test workflow and generate coverage report
poetry run pytest
```