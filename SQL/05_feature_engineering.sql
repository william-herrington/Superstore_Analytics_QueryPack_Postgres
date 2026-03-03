/*
Project 2: Feature Engineering Layer
Purpose: Add business-ready derived fields for BI slicing and ranking
*/

-- ======================================================
-- 1 Sales bucket
-- ======================================================

ALTER TABLE superstore.superstore_clean
ADD COLUMN sales_bucket TEXT;

UPDATE superstore.superstore_clean
SET sales_bucket = 
CASE 
    WHEN sales < 50 THEN 'Low'
    WHEN sales < 200 THEN 'Medium'
    WHEN sales < 500 THEN 'High'
    ELSE 'Very High'
END;



-- ======================================================
-- 2 Preview engineered fields
-- ======================================================

SELECT 
    order_id,
    order_date,
    category,
    sub_category,
    sales,
    sales_bucket
FROM superstore.superstore_clean
ORDER BY sales DESC
LIMIT 25;