log <- file(snakemake@log[[1]], open = "wt")
sink(log)
sink(log, type = "message")

library("SPIA")
library("graphite")
library(snakemake@params[["bioc_species_pkg"]], character.only = TRUE)

# provides library("tidyverse") and functions load_bioconductor_package() and
# get_prefix_col(), the latter requires snakemake@output[["samples"]] and
# snakemake@params[["covariate"]]
source(snakemake@params[["common_src"]])

pw_db <- snakemake@params[["pathway_db"]]
db <- readRDS(snakemake@input[["spia_db"]])

options(Ncpus = snakemake@threads)

diffexp <- read_tsv(snakemake@input[["diffexp"]]) %>%
    drop_na(ens_gene) %>%
    mutate(ens_gene = str_c("ENSEMBL:", ens_gene))
universe <- diffexp %>% pull(var = ens_gene)
sig_genes <- diffexp %>% filter(qval <= 0.05)

if (nrow(sig_genes) == 0) {
    cols <- c("Name", "pSize", "NDE", "pNDE", "tA", "pPERT", "pG", "pGFdr", "pGFWER", "Status")
    res <- data.frame(matrix(ncol = 10, nrow = 0, dimnames = list(NULL, cols)))
    # create empty perturbation plots
    pdf(file = snakemake@output[["plots"]])
    dev.off()
} else {
    # get logFC equivalent (the sum of beta scores of covariates of interest)

    beta_col <- get_prefix_col("b", colnames(sig_genes))

    beta <- sig_genes %>%
        dplyr::select(ens_gene, !!beta_col) %>%
        deframe()

    t <- tempdir(check = TRUE)
    olddir <- getwd()
    setwd(t)
    prepareSPIA(db, pw_db)
    res <- runSPIA(de = beta, all = universe, pw_db, plots = TRUE, verbose = TRUE)
    setwd(olddir)

    file.copy(file.path(t, "SPIAPerturbationPlots.pdf"), snakemake@output[["plots"]])
}
write_tsv(res, file = snakemake@output[["table"]])
