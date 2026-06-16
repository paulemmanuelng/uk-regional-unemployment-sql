-- data.sql
-- This file fills the "unemployment" table with the real ONS figures.
-- Run it AFTER schema.sql.
--
-- Source: UK Office for National Statistics (ONS), Regional Labour Market bulletins.
-- Unemployment rate, people aged 16+, Nov-Jan rolling quarter.
--   year 2026 = Nov 2025 to Jan 2026  (ONS bulletin, March 2026)
--   year 2025 = Nov 2024 to Jan 2025  (ONS bulletin, March 2025)
-- Both years are taken directly from the published ONS bulletins and
-- fact-checked against the source.

-- Clear out any existing rows first, so re-running this file
-- doesn't create duplicates while we're learning.
DELETE FROM unemployment;

-- Each line below is one row: (region, year, rate).
-- Read the very first one as:
--   "Into unemployment, set region='North East', year=2026, rate=7.1"

-- 2026 figures (Nov 2025 - Jan 2026)
INSERT INTO unemployment (region, year, rate) VALUES
    ('North East',               2026, 7.1),
    ('North West',               2026, 4.7),
    ('Yorkshire and The Humber', 2026, 6.0),
    ('East Midlands',            2026, 5.6),
    ('West Midlands',            2026, 6.1),
    ('East of England',          2026, 4.3),
    ('London',                   2026, 7.9),
    ('South East',               2026, 4.0),
    ('South West',               2026, 3.9),
    ('Wales',                    2026, 3.5),
    ('Scotland',                 2026, 3.9),
    ('Northern Ireland',         2026, 2.2),
    ('UK',                       2026, 5.2);

-- 2025 figures (Nov 2024 - Jan 2025)
INSERT INTO unemployment (region, year, rate) VALUES
    ('North East',               2025, 4.7),
    ('North West',               2025, 3.9),
    ('Yorkshire and The Humber', 2025, 4.0),
    ('East Midlands',            2025, 4.2),
    ('West Midlands',            2025, 4.5),
    ('East of England',          2025, 4.3),
    ('London',                   2025, 6.3),
    ('South East',               2025, 4.0),
    ('South West',               2025, 3.5),
    ('Wales',                    2025, 5.4),
    ('Scotland',                 2025, 3.7),
    ('Northern Ireland',         2025, 1.5),
    ('UK',                       2025, 4.4);
