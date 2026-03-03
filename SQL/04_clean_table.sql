/*
Project 2: Superstore Clean Layer
Purpose: Create analytics-ready clean table using validated typed columns
*/ 

-- ======================================================
-- 1 Create CLEAN table
-- ======================================================

DROP TABLE IF EXISTS superstore.superstore_clean;

CREATE TABLE superstore.superstore_clean AS 
SELECT 
    row_id,
    order_id,
    order_date_date AS order_date,
    ship_date_date  As ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales_num AS sales,
    stage_id
FROM superstore.superstore_stage
WHERE order_date_date  IS NOT NULL
    AND ship_date_date IS NOT NULL
    AND sales_num      IS NOT NULL;



-- ======================================================
-- 2 Verify clean row count
-- ======================================================

SELECT COUNT(*) AS clean_rows
FROM superstore.superstore_clean;