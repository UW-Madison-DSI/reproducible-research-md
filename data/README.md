# Data

## `study_data.csv`

A **simulated** teaching dataset comparing two ways of working, used by
`analysis/report.qmd`. It is not real observational data — it exists to
demonstrate a reproducible analysis end to end.

| Column        | Type    | Description                                        |
|---------------|---------|----------------------------------------------------|
| `id`          | integer | Row identifier (1–100)                             |
| `method`      | string  | Workflow used: `Traditional` or `Reproducible`     |
| `hours_saved` | numeric | Hours saved per month (higher is better)           |
| `errors`      | integer | Errors made in the period (lower is better)        |

## Provenance

The file is generated deterministically (fixed seed) by
[`generate_data.py`](generate_data.py):

```bash
python3 data/generate_data.py
```

Running it again reproduces the exact same `study_data.csv` — the
data-generating step is itself reproducible.
