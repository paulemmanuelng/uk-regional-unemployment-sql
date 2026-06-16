"""
make_charts.py
Reads the unemployment data straight from the SQLite database and saves
two chart images into the charts/ folder.

Run it (after building the database) with:
    python3 make_charts.py

The point of doing it this way: the charts come from the SAME database as
the SQL analysis, so they can never disagree with each other. Change the
data, re-run this, and the charts update themselves.
"""

import sqlite3
from pathlib import Path

import matplotlib
matplotlib.use("Agg")          # "Agg" = draw to a file, not to a screen window
import matplotlib.pyplot as plt

DB = "unemployment.db"
OUT = Path("charts")
OUT.mkdir(exist_ok=True)       # make the charts/ folder if it doesn't exist

# Colours (kept the same as the README tables for consistency)
BLUE_2025 = "#B5D4F4"          # light blue = last year
BLUE_2026 = "#185FA5"          # dark blue  = this year
RED   = "#E24B4A"              # rose  = unemployment went up (bad)
GREEN = "#1D9E75"              # fell  = unemployment went down (good)

con = sqlite3.connect(DB)


# ---------------------------------------------------------------------------
# Chart 1: unemployment rate by region, 2025 vs 2026 (paired bars)
# ---------------------------------------------------------------------------
# A self-join puts each region's two years on one row. We sort ascending so
# that, in a horizontal bar chart, the highest rate ends up at the TOP.
rows = con.execute(
    """
    SELECT a.region, b.rate, a.rate
    FROM unemployment AS a
    JOIN unemployment AS b ON a.region = b.region
    WHERE a.year = 2026 AND b.year = 2025
    ORDER BY a.rate ASC
    """
).fetchall()

regions = [r[0] for r in rows]
rate_2025 = [r[1] for r in rows]
rate_2026 = [r[2] for r in rows]
positions = range(len(regions))
bar_h = 0.4

fig, ax = plt.subplots(figsize=(9, 7))
ax.barh([p + bar_h / 2 for p in positions], rate_2026, height=bar_h,
        color=BLUE_2026, label="2026")
ax.barh([p - bar_h / 2 for p in positions], rate_2025, height=bar_h,
        color=BLUE_2025, label="2025")

# Write the value at the end of each bar
for p, v in zip(positions, rate_2026):
    ax.text(v + 0.08, p + bar_h / 2, f"{v:.1f}", va="center", fontsize=8, color=BLUE_2026)
for p, v in zip(positions, rate_2025):
    ax.text(v + 0.08, p - bar_h / 2, f"{v:.1f}", va="center", fontsize=8, color="#5A7FA5")

ax.set_yticks(list(positions))
ax.set_yticklabels(regions)
ax.set_xlim(0, 8.4)
ax.set_xlabel("Unemployment rate (%)")
ax.set_title("UK unemployment rate by region, Jan–Mar (2025 vs 2026)")
ax.legend(loc="lower right")
ax.spines[["top", "right"]].set_visible(False)
fig.tight_layout()
fig.savefig(OUT / "rate_by_region.png", dpi=150, facecolor="white")
plt.close(fig)


# ---------------------------------------------------------------------------
# Chart 2: year-on-year change (diverging bars)
# ---------------------------------------------------------------------------
rows = con.execute(
    """
    SELECT a.region, ROUND(a.rate - b.rate, 1)
    FROM unemployment AS a
    JOIN unemployment AS b ON a.region = b.region
    WHERE a.year = 2026 AND b.year = 2025
    ORDER BY (a.rate - b.rate) ASC
    """
).fetchall()

regions = [r[0] for r in rows]
change = [r[1] for r in rows]
colors = [RED if c > 0 else GREEN for c in change]   # colour encodes direction

fig, ax = plt.subplots(figsize=(9, 7))
ax.barh(regions, change, color=colors)
ax.axvline(0, color="#888888", linewidth=0.8)        # the zero line

for i, c in enumerate(change):
    ax.text(c + (0.04 if c >= 0 else -0.04), i, f"{c:+.1f}",
            va="center", ha="left" if c >= 0 else "right", fontsize=8)

ax.set_xlabel("Change in unemployment rate (percentage points)")
ax.set_title("Year-on-year change in UK unemployment, 2025 → 2026")
ax.spines[["top", "right"]].set_visible(False)
fig.tight_layout()
fig.savefig(OUT / "change_by_region.png", dpi=150, facecolor="white")
plt.close(fig)

con.close()
print("Saved charts/rate_by_region.png and charts/change_by_region.png")
