# One-time setup: pin this project's R packages with renv.
#
# Run once, from the project root, with R installed:
#
#     Rscript setup_renv.R
#
# This produces a real `renv.lock` (with correct versions and hashes) that you
# then commit. Collaborators reproduce your exact package versions with
# `renv::restore()`. repo2docker/Binder also detects renv.lock automatically.

# Install renv itself if it isn't available yet.
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv", repos = "https://cloud.r-project.org")
}

# Initialise renv for this project without letting it auto-scan/snapshot yet,
# so we control exactly which packages are recorded.
renv::init(bare = TRUE)

# The packages the worked example (analysis/report.qmd) depends on.
pkgs <- c("readr", "dplyr", "ggplot2", "knitr", "here", "rmarkdown")
renv::install(pkgs)

# Write renv.lock capturing the resolved versions + hashes.
renv::snapshot(packages = pkgs, prompt = FALSE)

cat("\nDone. Commit renv.lock (and the renv/ directory) to version control.\n")
cat("Reproduce elsewhere with: renv::restore()\n")
