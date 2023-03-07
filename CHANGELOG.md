# Changelog

## [2.6.1](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/compare/v2.6.0...v2.6.1) (2023-03-07)


### Bug Fixes

* index only is single-threaded no matter what ([001660e](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/001660e9e44f471c4f11b7fcc2ab16a9fa13c377))

## [2.6.0](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/compare/v2.5.0...v2.6.0) (2023-02-20)


### Features

* adapt to fgsea updates, configure fgsea precision by minimum achievable p-value ([dcd77ca](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/dcd77ca90ead1213acd0c293d500c18c0e579222))
* extended diffexp tables with gene description ([#51](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/51)) ([09dc9dd](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/09dc9ddce9d1440267baecb191e15c2a5a4874f1))
* generate batch effect corrected matrix output ([#47](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/47)) ([cd3ae35](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/cd3ae3564a65a53736a72758d898e9c78c916b9a))
* join sample expressions into diffexp table ([#52](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/52)) ([123923d](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/123923dc7e3fb4646a3412a3204ae05d7e8fdd6f))


### Bug Fixes

* channel order for bioconductor package download ([f57044a](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/f57044a4a1a571fcf21ce7881b32f82a3fd09265))
* correct default value for representative_transcripts and check for existence of path ([#59](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/59)) ([a85b268](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/a85b268699c74f4076d68158adfe3e3717826bbf))
* Feature/update cutadapt wrapper ([#67](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/67)) ([29d7967](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/29d7967fac57dfdd4a8acd61d75016d8d83b5a46))
* fix channel order under strict priorities ([bdbfb10](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/bdbfb103e0298b2cbee6f99802236d794d0f4797))
* fix default minimum p-value in fgsea ([#61](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/61)) ([a6a857d](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/a6a857dff26d39dc16d98c93351cf5a903f15120))
* fix gene-level p-value adjustment (use Benjamini-Hochberg instead of Bonferroni-Holm) ([#64](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/64)) ([6ea1682](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/6ea1682d20b0dccd021d93359f53c3fcec9c869d))
* fixed custom representative transcript handling; various little bug fixes ([#54](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/54)) ([3df522c](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/3df522c75ff6d62ae031ba2738c1f2bde722ee34))
* for some rules, omit software env when caching ([#63](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/63)) ([1d2e3a9](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/1d2e3a9515701645207b57532e7045e94b3b5f3b))
* Only handle canonical column in target mapping if it is actually present. ([c867026](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/c867026d94490bcf02439324ca470cf7cd2e173a))
* use correct path of vega plot template even when running workflow as a module ([68b8817](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/68b8817974063fbb4d1c36cf8515ecdfa7de514c))

## [2.5.0](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/compare/v2.4.3...v2.5.0) (2023-02-20)


### Features

* adapt to fgsea updates, configure fgsea precision by minimum achievable p-value ([dcd77ca](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/dcd77ca90ead1213acd0c293d500c18c0e579222))
* extended diffexp tables with gene description ([#51](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/51)) ([09dc9dd](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/09dc9ddce9d1440267baecb191e15c2a5a4874f1))
* generate batch effect corrected matrix output ([#47](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/47)) ([cd3ae35](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/cd3ae3564a65a53736a72758d898e9c78c916b9a))
* join sample expressions into diffexp table ([#52](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/52)) ([123923d](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/123923dc7e3fb4646a3412a3204ae05d7e8fdd6f))


### Bug Fixes

* channel order for bioconductor package download ([f57044a](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/f57044a4a1a571fcf21ce7881b32f82a3fd09265))
* correct default value for representative_transcripts and check for existence of path ([#59](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/59)) ([a85b268](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/a85b268699c74f4076d68158adfe3e3717826bbf))
* Feature/update cutadapt wrapper ([#67](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/67)) ([29d7967](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/29d7967fac57dfdd4a8acd61d75016d8d83b5a46))
* fix channel order under strict priorities ([bdbfb10](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/bdbfb103e0298b2cbee6f99802236d794d0f4797))
* fix default minimum p-value in fgsea ([#61](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/61)) ([a6a857d](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/a6a857dff26d39dc16d98c93351cf5a903f15120))
* fix gene-level p-value adjustment (use Benjamini-Hochberg instead of Bonferroni-Holm) ([#64](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/64)) ([6ea1682](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/6ea1682d20b0dccd021d93359f53c3fcec9c869d))
* fixed custom representative transcript handling; various little bug fixes ([#54](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/54)) ([3df522c](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/3df522c75ff6d62ae031ba2738c1f2bde722ee34))
* for some rules, omit software env when caching ([#63](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/issues/63)) ([1d2e3a9](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/1d2e3a9515701645207b57532e7045e94b3b5f3b))
* Only handle canonical column in target mapping if it is actually present. ([c867026](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/c867026d94490bcf02439324ca470cf7cd2e173a))
* use correct path of vega plot template even when running workflow as a module ([68b8817](https://github.com/sansterbioanalytics/rna-seq-kallisto-sleuth/commit/68b8817974063fbb4d1c36cf8515ecdfa7de514c))

## [2.4.3](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/compare/v2.4.2...v2.4.3) (2023-02-06)


### Bug Fixes

* Feature/update cutadapt wrapper ([#67](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/issues/67)) ([29d7967](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/commit/29d7967fac57dfdd4a8acd61d75016d8d83b5a46))

## [2.4.2](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/compare/v2.4.1...v2.4.2) (2022-12-02)


### Bug Fixes

* fix gene-level p-value adjustment (use Benjamini-Hochberg instead of Bonferroni-Holm) ([#64](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/issues/64)) ([6ea1682](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/commit/6ea1682d20b0dccd021d93359f53c3fcec9c869d))

## [2.4.1](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/compare/v2.4.0...v2.4.1) (2022-11-04)


### Bug Fixes

* channel order for bioconductor package download ([f57044a](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/commit/f57044a4a1a571fcf21ce7881b32f82a3fd09265))
* correct default value for representative_transcripts and check for existence of path ([#59](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/issues/59)) ([a85b268](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/commit/a85b268699c74f4076d68158adfe3e3717826bbf))
* fix channel order under strict priorities ([bdbfb10](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/commit/bdbfb103e0298b2cbee6f99802236d794d0f4797))
* fix default minimum p-value in fgsea ([#61](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/issues/61)) ([a6a857d](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/commit/a6a857dff26d39dc16d98c93351cf5a903f15120))
* for some rules, omit software env when caching ([#63](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/issues/63)) ([1d2e3a9](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/commit/1d2e3a9515701645207b57532e7045e94b3b5f3b))

## [2.4.0](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/compare/v2.3.2...v2.4.0) (2022-03-29)


### Features

* adapt to fgsea updates, configure fgsea precision by minimum achievable p-value ([dcd77ca](https://github.com/snakemake-workflows/rna-seq-kallisto-sleuth/commit/dcd77ca90ead1213acd0c293d500c18c0e579222))
