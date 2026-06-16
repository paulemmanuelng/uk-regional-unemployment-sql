-- schema.sql
-- This file is the "blueprint" for our database.
-- It defines what tables exist and what columns they have.
-- Running this file creates an empty table, ready for data.

-- Data source: UK Office for National Statistics (ONS)
-- Regional Labour Market bulletin, March 2026.
-- Unemployment rate = % of people aged 16+ who are unemployed.
-- Period covered: November to January (a rolling 3-month average),
--   labelled here by the year it ends in (2025 and 2026).

-- "DROP TABLE IF EXISTS" deletes the table first IF it already exists.
-- This lets us re-run this file safely while we're learning,
-- without getting "table already exists" errors.
DROP TABLE IF EXISTS unemployment;

-- "CREATE TABLE" makes a new table called "unemployment".
-- Everything inside the (parentheses) defines its columns.
CREATE TABLE unemployment (
    -- id: a unique number for each row. PRIMARY KEY means
    -- "this is the unique identifier". SQLite fills it in
    -- automatically if we don't provide one.
    id      INTEGER PRIMARY KEY,

    -- region: the name of the UK region or nation. TEXT = words.
    -- NOT NULL means this column can never be left empty.
    region  TEXT    NOT NULL,

    -- year: which year the figure is for (2025 or 2026).
    -- INTEGER = a whole number.
    year    INTEGER NOT NULL,

    -- rate: the unemployment rate, e.g. 7.1.
    -- REAL = a number that can have decimals.
    rate    REAL    NOT NULL
);
