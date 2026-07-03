# Reproducible Research

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/UW-Madison-DSI/reproducible-research-md/main?urlpath=rstudio)

This repository is **both a talk and a template**. It explains the principles of
reproducible research *and* is itself a small, working reproducible project you
can clone and build on — with a particular focus on Quarto and MyST Markdown for
transparent, shareable, executable research documents.

- `ppt.Rmd` — a Quarto presentation *about* reproducible research (the talk).
- `analysis/report.qmd` — a small, complete reproducible analysis (the example).

## Key Features

- Demonstrates reproducible workflows using R Markdown and Quarto.
- Integrates MyST Markdown for improved scientific documentation and interoperability.
- Ships a worked example (`analysis/report.qmd`) that goes from raw data to figure and table.
- Reproducible three ways: one-click Binder, local Quarto, or Docker.

## Repository Structure

```
├── ppt.Rmd / ppt.html      # the talk: a presentation on reproducible research
├── analysis/report.qmd     # worked example: data → code → figure → table
├── data/
│   ├── study_data.csv      # sample dataset used by the analysis
│   ├── generate_data.py    # provenance: deterministically regenerates the data
│   └── README.md           # data dictionary
├── binder/                 # one-click reproducible environment (Binder)
│   ├── install.R
│   └── runtime.txt
├── Dockerfile              # bit-for-bit local reproduction
└── reproducible-research.Rproj
```

## Reproduce the Worked Example

Pick whichever fits your setup — all three run the same analysis:

**1. One-click in the browser (no install).** Click the Binder badge above, then
open `analysis/report.qmd` and render it. Binder builds the environment from
`binder/`.

**2. Locally with Quarto.**

```bash
# Install Quarto (https://quarto.org) and R, then:
Rscript binder/install.R          # install the R packages
quarto render analysis/report.qmd # builds analysis/report.html
```

**3. With Docker (bit-for-bit).**

```bash
docker build -t reproducible-research .
docker run --rm -v "$PWD:/project" reproducible-research
```

Want to change the data? Edit or rerun `python3 data/generate_data.py`, then
re-render — every number, figure, and table updates automatically.

## Why This Matters

- **Your future self benefits first.** The document *is* the analysis — no hunting for the script that made a figure six months later.
- **Trust without re-explaining.** Collaborators, reviewers, and students can see data → code → result in one place, so findings are verifiable rather than "trust me."
- **Updates are cheap.** New data? Re-render once and every number, table, and figure updates automatically — no copy-paste, no stale results.
- **Faster onboarding.** New team members run one command (or click one badge) instead of spending days configuring an environment.
- **Reusable and citable.** With an archive and a DOI, others can build on your work — and cite you.

## Getting Started

You don't have to adopt everything at once. Each rung below is useful on its own and takes only minutes:

1. **Write in Quarto/R Markdown.** Mix prose with a code chunk — that alone gives you literate programming, with zero extra infrastructure.
2. **Pin your R packages** with `renv::snapshot()` so the analysis runs the same next year.
3. **Add a `requirements.txt`/`environment.yml` and a Binder badge** so anyone can run your work in a browser with no install.
4. **Add Docker or a Zenodo DOI** only when you need bit-for-bit environments or permanent, citable archives.

### Rendering the example presentation

```bash
# Install Quarto from https://quarto.org (or: brew install quarto)
quarto preview ppt.Rmd   # live preview in the browser
quarto render ppt.Rmd    # build ppt.html
```

The rendered slides are also available as `ppt.html`.