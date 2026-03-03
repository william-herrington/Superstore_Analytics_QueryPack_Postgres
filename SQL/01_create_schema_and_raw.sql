/*
Project 2: Superstore Raw Layer
Purpose: Create schema + raw ingestion table (all fields stored as TEXT)
*/

-- ======================================================
-- 1 Create schema
-- ======================================================

CREATE SCHEMA IF NOT EXISTS superstore;



-- ======================================================
-- 2 Drop + create RAW table
-- ======================================================

DROP TABLE IF EXISTS superstore.superstore_raw;

CREATE TABLE superstore.superstore_raw (
    row_id TEXT,
    order_id TEXT,
    order_date TEXT,
    ship_date TEXT,
    ship_mode TEXT,
    customer_id TEXT,
    customer_name TEXT,
    segment TEXT,
    country TEXT,
    city TEXT,
    state TEXT,
    postal_code TEXT,
    region TEXT,
    product_id TEXT,
    category TEXT,
    sub_category TEXT,
    product_name TEXT,
    sales
);