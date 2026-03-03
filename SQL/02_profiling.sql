/* 
Project 2: Superstore Profiling Layer
Purpose: Identify missing values, formatting issues, and anomalies
*/

-- ======================================================
-- 1 Row count verification
-- ======================================================

SELECT COUNT(*) AS total_rows
FROM superstore.superstore_raw;



-- ======================================================
-- 2 Check for missing key fields
-- ======================================================

SELECT 
    SUM(CASE WHEN NULL IF(TRIM(row_id), '') IS NULL THEN 1 ELSE 0 END) AS missing_row_id,
    SUM(CASE WHEN NULLIF(TRIM(order_id), '') IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN NULLIF(TRIM(order_date), '') IS NULL THEN 1 ELSE 0 END) AS missing_order_date,
    SUM(CASE WHEN NULLIF(TRIM(ship_date), '') IS NULL THEN 1 ELSE 0 END) AS missing_ship_date,
    SUM(CASE WHEN NULLIF(TRIM(customer_id), '') IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN NULLIF(TRIM(product_id), '') IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN NULLIF(TRIM(category), '') IS NULL THEN 1 ELSE 0 END) AS missing_category,
    SUM(CASE WHEN NULLIF(TRIM(sub_category), '') IS NULL THEN 1 ELSE 0 END) AS missing_sub_category,
    SUM(CASE WHEN NULLIF(TRIM(sales), '') IS NULL THEN 1 ELSE 0 END) AS missing_sales
FROM superstore.superstore_raw;



-- ======================================================
-- 3 Date format preview (confirm what order_date Looks like)
-- ======================================================

SELECT order_date, ship_date
FROM superstore.superstore_raw
LIMIT 25;



-- ======================================================
-- 4 Check sales for non-numeric characters (currency, commas, etc.)
-- ======================================================

SELECT sales
FROM superstore.superstore_raw
WHERE sales ~ '[0-9\.\-]'
LIMIT 25;



-- ======================================================
-- 5 Category / sub-category distributions
-- ======================================================

SELECT category, COUNT(*) AS cnt
FROM superstore.superstore_raw
GROUP BY category
ORDER BY cnt DESC;

SELECT sub_category, COUNT(*) AS COUNT
FROM superstore.superstore_raw
GROUP BY sub_category
ORDER BY cnt DESC;



-- ======================================================
-- 6 Duplicate checks 
-- ======================================================

SELECT row_id, COUNT(*) AS dup_count
FROM superstore.superstore_raw
GROUP BY row_id
HAVING COUNT(*) > 1
ORDER BY dup_count DESC;