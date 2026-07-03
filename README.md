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

### Pinning R package versions with renv (optional)

Rung 2 of the ladder: lock the *exact* package versions so the analysis runs the
same next year. Run once (with R installed) to generate a real `renv.lock`:

```bash
Rscript setup_renv.R
```

Commit the resulting `renv.lock`. Anyone can then reproduce your exact
environment with:

```r
renv::restore()
```

> Note: this repo's Binder image is built from `binder/`, and the Docker image
> from a pinned CRAN snapshot — so `renv.lock` mainly benefits local development
> and collaborators who clone the project.

## Use This as a Template for Your Own Research

This repo is designed to be **cloned and adapted**. To turn it into your own
reproducible project:

1. **Get your own copy.** On GitHub, click **Use this template → Create a new
   repository** (or fork it). Clone it locally:
   ```bash
   git clone https://github.com/<you>/<your-repo>.git
   cd <your-repo>
   ```
2. **Add your data.** Drop your file(s) in `data/`, and update
   `data/README.md` with a short data dictionary and where the data came from.
   (If your data is generated, keep a script like `generate_data.py` so the data
   step is reproducible too.)
3. **Write your analysis.** Edit `analysis/report.qmd`: point `read_csv(...)` at
   your file, then replace the summary/plot/model chunks with your own. Keep
   prose and code together so results never drift out of sync.
4. **Declare your dependencies** in one place and keep them consistent:
   - `binder/install.R` — packages for Binder
   - `Dockerfile` — the same packages for Docker
   - `setup_renv.R` — the same packages for the `renv.lock`
5. **Update the Binder badge.** In this README, change the badge URL from
   `UW-Madison-DSI/reproducible-research-md` to `<you>/<your-repo>`.
6. **Render and commit.**
   ```bash
   quarto render analysis/report.qmd
   git add -A && git commit -m "My reproducible analysis" && git push
   ```
7. **(Optional) Make it citable.** Connect the repo to
   [Zenodo](https://zenodo.org) to mint a DOI on each GitHub release.

### Adapting checklist

- [ ] Replaced the dataset in `data/` and updated `data/README.md`
- [ ] Rewrote `analysis/report.qmd` for your question
- [ ] Listed your packages in `binder/install.R`, `Dockerfile`, and `setup_renv.R`
- [ ] Updated the Binder badge URL in this README
- [ ] Rendered the report and confirmed it builds cleanly
- [ ] (Optional) Generated `renv.lock` via `Rscript setup_renv.R`
- [ ] (Optional) Set up a Zenodo DOI

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