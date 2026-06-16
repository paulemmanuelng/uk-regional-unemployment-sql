-- queries.sql
-- Analysis queries for the UK regional unemployment project.
-- Run any of these against the database, e.g.:
--   sqlite3 unemployment.db < queries.sql
-- or paste one at a time inside the sqlite3 shell.

-- ---------------------------------------------------------------
-- Q1. Which regions had the worst unemployment in 2026?
--     (worst at the top)
-- ---------------------------------------------------------------
SELECT region, rate
FROM unemployment
WHERE year = 2026
ORDER BY rate DESC;

-- ---------------------------------------------------------------
-- Q2. 2026 vs 2025 side by side, with the change.
--     This is a "self-join": the table joined to itself so we can
--     put each region's two years on one line.
-- ---------------------------------------------------------------
SELECT
    a.region                  AS region,
    b.rate                    AS rate_2025,
    a.rate                    AS rate_2026,
    ROUND(a.rate - b.rate, 1) AS change
FROM unemployment AS a
JOIN unemployment AS b ON a.region = b.region
WHERE a.year = 2026 AND b.year = 2025
ORDER BY change DESC;

-- ---------------------------------------------------------------
-- Q3. Summary stats per year, across the 12 regions.
--     (The 'UK' row is excluded so we don't double-count the
--      national total alongside the regions.)
-- ---------------------------------------------------------------
SELECT
    year,
    ROUND(AVG(rate), 2) AS avg_rate,
    MIN(rate)           AS lowest,
    MAX(rate)           AS highest
FROM unemployment
WHERE region != 'UK'
GROUP BY year;

-- ---------------------------------------------------------------
-- Q4. How many of the 12 regions got worse in 2026 vs 2025?
-- ---------------------------------------------------------------
SELECT COUNT(*) AS regions_that_rose
FROM unemployment AS a
JOIN unemployment AS b ON a.region = b.region
WHERE a.year = 2026
  AND b.year = 2025
  AND a.region != 'UK'
  AND a.rate > b.rate;
