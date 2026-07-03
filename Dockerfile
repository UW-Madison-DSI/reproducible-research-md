# Bit-for-bit local reproduction of the worked example.
#
#   docker build -t reproducible-research .
#   docker run --rm -v "$PWD:/project" reproducible-research
#
# The rocker image pins the R version; the CRAN snapshot in install.R's
# companion (runtime date) keeps package versions stable.
FROM rocker/r-ver:4.3.0

# System libraries commonly needed by the tidyverse / rendering.
RUN apt-get update && apt-get install -y --no-install-recommends \
      libxml2-dev libssl-dev libcurl4-openssl-dev pandoc \
    && rm -rf /var/lib/apt/lists/*

# Install a pinned CRAN snapshot for reproducible package versions.
RUN echo 'options(repos = c(CRAN = "https://packagemanager.posit.co/cran/2024-01-01"))' \
      >> /usr/local/lib/R/etc/Rprofile.site

RUN R -e "install.packages(c('readr','dplyr','ggplot2','knitr','here','rmarkdown'))"

WORKDIR /project

# Render the report by default. Mount the repo at /project (see run command).
CMD ["R", "-e", "rmarkdown::render('analysis/report.qmd')"]
