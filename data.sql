-- data.sql
-- This file fills the "unemployment" table with the real ONS figures.
-- Run it AFTER schema.sql.
--
-- Source: UK Office for National Statistics (ONS), Regional Labour Market bulletins.
-- Unemployment rate, people aged 16+, Jan-Mar quarter (the latest available).
--   year 2026 = Jan to Mar 2026  (ONS bulletin, May 2026)
--   year 2025 = Jan to Mar 2025  (ONS bulletin, May 2025)
-- Both years are taken directly from the published ONS bulletins and
-- fact-checked against the source.

-- Clear out any existing rows first, so re-running this file
-- doesn't create duplicates while we're learning.
DELETE FROM unemployment;

-- Each line below is one row: (region, year, rate).
-- Read the very first one as:
--   "Into unemployment, set region='North East', year=2026, rate=5.5"

-- 2026 figures (Jan - Mar 2026)
INSERT INTO unemployment (region, year, rate) VALUES
    ('North East',               2026, 5.5),
    ('North West',               2026, 4.9),
    ('Yorkshire and The Humber', 2026, 5.8),
    ('East Midlands',            2026, 5.5),
    ('West Midlands',            2026, 5.4),
    ('East of England',          2026, 4.2),
    ('London',                   2026, 7.3),
    ('South East',               2026, 3.8),
    ('South West',               2026, 4.5),
    ('Wales',                    2026, 3.6),
    ('Scotland',                 2026, 4.4),
    ('Northern Ireland',         2026, 2.1),
    ('UK',                       2026, 5.0);

-- 2025 figures (Jan - Mar 2025)
INSERT INTO unemployment (region, year, rate) VALUES
    ('North East',               2025, 5.1),
    ('North West',               2025, 4.1),
    ('Yorkshire and The Humber', 2025, 4.9),
    ('East Midlands',            2025, 4.2),
    ('West Midlands',            2025, 4.5),
    ('East of England',          2025, 4.5),
    ('London',                   2025, 6.2),
    ('South East',               2025, 4.1),
    ('South West',               2025, 3.5),
    ('Wales',                    2025, 5.2),
    ('Scotland',                 2025, 4.3),
    ('Northern Ireland',         2025, 1.6),
    ('UK',                       2025, 4.5);
