# UK Regional Unemployment: 2026 vs 2025 🇬🇧

My first SQL project — analysing how unemployment changed across the regions
and nations of the UK between 2025 and 2026, using real data from the
Office for National Statistics (ONS).

Built with **SQLite**.

## The question

Did unemployment rise or fall across the UK from 2025 to 2026, and which
regions changed the most?

## Data source

UK Office for National Statistics (ONS), Regional Labour Market bulletins —
unemployment rate, people aged 16+, for the November–January rolling quarter.
Both years are taken directly from the published bulletins and fact-checked
against the source.

- `year = 2026` → Nov 2025–Jan 2026 ([ONS bulletin, March 2026](https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/bulletins/regionallabourmarket/march2026))
- `year = 2025` → Nov 2024–Jan 2025 ([ONS bulletin, March 2025](https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/bulletins/regionallabourmarket/march2025))

## How to build and run it

You need [SQLite](https://www.sqlite.org/) (pre-installed on macOS).

```bash
# 1. Create the database and the table
sqlite3 unemployment.db < schema.sql

# 2. Load the data
sqlite3 unemployment.db < data.sql

# 3. Run the analysis
sqlite3 -header -column unemployment.db < queries.sql
```

## Project structure

| File | What it does |
|------|--------------|
| `schema.sql`  | Defines the `unemployment` table (the blueprint) |
| `data.sql`    | Loads the 26 rows of real ONS figures |
| `queries.sql` | The analysis questions, written as SQL |
| `README.md`   | This file |

## Key findings

Unemployment rose almost everywhere. **9 of the 12 regions got worse**, the
UK-wide rate climbed from **4.4% to 5.2%**, and the average regional rate went
from **4.17% to 4.93%**.

| Region | 2025 | 2026 | Change |
|--------|-----:|-----:|-------:|
| North East | 4.7 | 7.1 | **+2.4** |
| Yorkshire & The Humber | 4.0 | 6.0 | +2.0 |
| West Midlands | 4.5 | 6.1 | +1.6 |
| London | 6.3 | 7.9 | +1.6 |
| East Midlands | 4.2 | 5.6 | +1.4 |
| North West | 3.9 | 4.7 | +0.8 |
| Northern Ireland | 1.5 | 2.2 | +0.7 |
| South West | 3.5 | 3.9 | +0.4 |
| Scotland | 3.7 | 3.9 | +0.2 |
| East of England | 4.3 | 4.3 | 0.0 |
| South East | 4.0 | 4.0 | 0.0 |
| Wales | 5.4 | 3.5 | **−1.9** |

- 📈 **North East** had the sharpest rise (+2.4 points).
- 📉 **Wales** was the only region to improve (−1.9 points).
- London remained the highest overall (7.9%); Northern Ireland the lowest (2.2%).

## What I learned

`CREATE TABLE` · `INSERT` · `SELECT` · `WHERE` · `ORDER BY` ·
`JOIN` (self-join) · aggregates (`AVG`, `MIN`, `MAX`, `COUNT`) · `GROUP BY`.
