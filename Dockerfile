# Bit-for-bit local reproduction of the worked example.
#
#   docker build -t reproducible-research .
#   docker run --rm -v "$PWD:/project" reproducible-research
#
# The rocker image pins the R version; the CRAN snapshot below keeps package
# versions stable. Quarto is installed so the .qmd renders with its full
# format:/theme: options (rmarkdown::render alone ignores those).
FROM rocker/r-ver:4.3.0

ARG QUARTO_VERSION=1.4.550

# System libraries needed by the tidyverse and for downloading Quarto.
RUN apt-get update && apt-get install -y --no-install-recommends \
      libxml2-dev libssl-dev libcurl4-openssl-dev pandoc curl \
    && rm -rf /var/lib/apt/lists/*

# Install the Quarto CLI (renders .qmd with its native YAML options).
# Detect the architecture so this builds on both amd64 (CI/Binder) and
# arm64 (Apple Silicon).
RUN ARCH="$(dpkg --print-architecture)" \
    && curl -L -o /tmp/quarto.deb \
      "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-${ARCH}.deb" \
    && apt-get update && apt-get install -y /tmp/quarto.deb \
    && rm /tmp/quarto.deb && rm -rf /var/lib/apt/lists/*

# Install a pinned CRAN snapshot for reproducible package versions.
RUN echo 'options(repos = c(CRAN = "https://packagemanager.posit.co/cran/2024-01-01"))' \
      >> /usr/local/lib/R/etc/Rprofile.site

RUN R -e "install.packages(c('readr','dplyr','ggplot2','knitr','here','rmarkdown'))"

WORKDIR /project

# Render the report with Quarto by default. Mount the repo at /project.
CMD ["quarto", "render", "analysis/report.qmd"]
