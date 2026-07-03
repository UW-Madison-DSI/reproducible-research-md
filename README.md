# Reproducible Research

This repository demonstrates the principles and practical workflow of reproducible research, with a particular focus on the integration of MyST Markdown and Quarto for creating transparent, shareable, and executable research documents.

The file `ppt.Rmd` contains the source for a presentation built using Quarto, showcasing how to generate reproducible slides directly from code, data, and documentation within the same environment.

## Key Features

- Demonstrates reproducible workflows using R Markdown and Quarto.
- Integrates MyST Markdown for improved scientific documentation and interoperability.
- Provides an example presentation (ppt.Rmd) to illustrate reproducible research in practice.

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