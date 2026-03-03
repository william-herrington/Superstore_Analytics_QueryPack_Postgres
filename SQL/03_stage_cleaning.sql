/*
Project 2: Superstore Stage Layer
Purpose: Create staging table, standardize text, and cast to typed columns
*/

-- ======================================================
-- 1 Create STAGE table (do not modify RAW)
-- ======================================================

DROP TABLE IF EXISTS superstore.superstore_stage;

CREATE TABLE superstore.superstore_stage AS 
SELECT * 
FROM superstore.superstore_raw;

ALTER TABLE superstore.superstore_stage
ADD COLUMN stage_id BIGSERIAL PRIMARY KEY;



-- ======================================================
-- 2 Standardize text fields
-- ======================================================

UPDATE superstore.superstore_stage
SET 
    row_id        = NULLIF(TRIM(row_id), ''),
    order_id      = NULLIF(TRIM(order_id), ''),
    order_date    = NULLIF(TRIM(order_date), ''),
    ship_date     = NULLIF(TRIM(ship_date), ''),
    ship_mode     = NULLIF(TRIM(ship_mode), ''),
    customer_id   = NULLIF(TRIM(customer_id), ''),
    customer_name = NULLIF(TRIM(customer_name), ''),
    segment       = NULLIF(TRIM(segment), ''),
    country       = NULLIF(TRIM(country), ''),
    city          = NULLIF(TRIM(city), ''),
    state         = NULLIF(TRIM(state), ''),
    postal_code   = NULLIF(TRIM(postal_code), ''),
    region        = NULLIF(TRIM(region), ''),
    product_id    = NULLIF(TRIM(product_id), ''),
    category      = NULLIF(INITCAP(TRIM(category)), ''),
    sub_category  = NULLIF(INITCAP(TRIM(sub_category)), ''),
    product_name  = NULLIF(TRIM(product_name), ''),
    sales         = NULLIF(TRIM(sales), '');



-- ======================================================
-- 3 Strip non-numeric characters from sales
-- ======================================================

UPDATE superstore.superstore_stage
SET 
    sales = NULLIF(REGEXP_REPLACE(sales, '[^0-9\.\-]', '', 'g'), '');



-- ======================================================
-- 4 Add typed columns
-- ======================================================

ALTER TABLE superstore.superstore_stage
ADD COLUMN order_date_date DATE,
ADD COLUMN ship_date_date  DATE,
ADD COLUMN sales_num       NUMERIC;



-- ======================================================
-- 5 Cast dates (MM/DD/YYYY)
-- ======================================================

UPDATE superstore.superstore_stage 
SET 
    order_date_date = TO_DATE(order_date, 'DD/MM/YYYY'),
    ship_date_date = TO_DATE(ship_date, 'DD/MM/YYYY')
WHERE order_date IS NOT NULL,
    AND ship_date IS NOT NULL;



-- ======================================================
-- 6 Cast sales to numeric
-- ======================================================

UPDATE superstore.superstore_stage
SET sales_num = sales::NUMERIC
WHERE sales IS NOT NULL;



-- ======================================================
-- 7 Validation checks
-- ======================================================

SELECT COUNT(*) AS bad_order_dates
FROM superstore.superstore_stage
WHERE order_date IS NOT NULL
    AND order_date_date IS NULL;

SELECT COUNT(*) AS bad_ship_dates
FROM superstore.superstore_stage
WHERE ship_date IS NOT NULL
    AND ship_date_date IS NULL;

SELECT COUNT(*) AS bad_sales
FROM superstore.superstore_stage
WHERE sales IS NOT NULL
    AND sales_num IS NULL;