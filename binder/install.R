# Packages needed to render analysis/report.qmd on Binder.
# repo2docker runs this during the image build.
install.packages(c(
  "readr",
  "dplyr",
  "ggplot2",
  "knitr",
  "here",
  "rmarkdown"
))
