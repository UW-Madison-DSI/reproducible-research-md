"""Generate the teaching dataset used in analysis/report.qmd.

This script documents the provenance of `study_data.csv`: it is a *simulated*
dataset comparing a "Traditional" vs. a "Reproducible" workflow. Regenerate it
deterministically with:

    python3 data/generate_data.py

The fixed seed guarantees the same file every time -- reproducibility applies
to the data-generating step too, not just the analysis.
"""

import csv
import random

SEED = 42
N_PER_GROUP = 50
OUTPUT = "data/study_data.csv"


def main() -> None:
    rng = random.Random(SEED)
    rows = []
    row_id = 1
    for method, hours_mean, hours_sd, err_lambda in [
        ("Traditional", 5.0, 2.0, 5.0),
        ("Reproducible", 15.0, 3.0, 2.0),
    ]:
        for _ in range(N_PER_GROUP):
            hours = round(rng.gauss(hours_mean, hours_sd), 2)
            # simple Poisson-ish count via summing exponentials (Knuth)
            errors = poisson(rng, err_lambda)
            rows.append((row_id, method, hours, errors))
            row_id += 1

    with open(OUTPUT, "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["id", "method", "hours_saved", "errors"])
        writer.writerows(rows)

    print(f"Wrote {len(rows)} rows to {OUTPUT}")


def poisson(rng: random.Random, lam: float) -> int:
    """Knuth's algorithm for Poisson sampling (keeps deps to the stdlib)."""
    import math

    l = math.exp(-lam)
    k = 0
    p = 1.0
    while True:
        k += 1
        p *= rng.random()
        if p <= l:
            return k - 1


if __name__ == "__main__":
    main()
