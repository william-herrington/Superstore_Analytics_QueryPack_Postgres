/*
Project: 2: Analytics Query Pack (CTEs + Windown Functions)
Purpose: Show BI-grade SQL patterns (rolling metrics, ranking, cohorts)
*/

-- ======================================================
-- 1 Rolling 7-day and 30-day sales
-- ======================================================

WITH daily_sales AS (
    SELECT 
        order_date,
        SUM(sales) AS sales_daily
    FROM superstore.superstore_clean
    GROUP BY order_date
)
SELECT 
    order_date,
    sales_daily,
    SUM(sales_daily) OVER (
        ORDER BY order_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    )  AS sales_rolling_7d,
    SUM(sales_daily) OVER (
        ORDER BY order_date
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    )  AS sales_rolling_30d
FROM daily_sales
ORDER BY order_date;



-- ======================================================
-- 2 Top 10 products by sales (ranking)
-- ======================================================

WITH product_sales AS (
    SELECT
        product_id,
        product_name,
        category,
        sub_category,
        SUM(sales) AS total_sales
    FROM superstore.superstore_clean
    GROUP BY product_id, product_name, category, sub_category
),
ranked AS (
    SELECT
        *,
        DENSE_RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
    FROM product_sales
)
SELECT
    sales_rank,
    product_id,
    product_name,
    category,
    sub_category,
    total_sales
FROM ranked
WHERE sales_rank <= 10
ORDER BY sales_rank, total_sales DESC;



-- ======================================================
-- 3 customer cohort retention (month-based)
-- ======================================================

WITH orders AS (
    SELECT DISTINCT
        customer_id,
        order_id,
        DATE_TRUNC('month', order_date)::date AS order_month
    FROM superstore.superstore_clean
    WHERE customer_id IS NOT NULL
),
first_month AS (
    SELECT
        customer_id,
        MIN(order_month) AS cohort_month
    FROM orders
    GROUP BY customer_id
),
cohorted AS (
    SELECT
        o.customer_id,
        f.cohort_month,
        o.order_month,
        (EXTRACT(YEAR FROM o.order_month) - EXTRACT(YEAR FROM f.cohort_month)) * 12
          + (EXTRACT(MONTH FROM o.order_month) - EXTRACT(MONTH FROM f.cohort_month)) AS months_since_cohort
    FROM orders o
    JOIN first_month f
      ON o.customer_id = f.customer_id
),
retention AS (
    SELECT
        cohort_month,
        months_since_cohort,
        COUNT(DISTINCT customer_id) AS active_customers
    FROM cohorted
    GROUP BY cohort_month, months_since_cohort
),
cohort_size AS (
    SELECT
        cohort_month,
        MAX(active_customers) FILTER (WHERE months_since_cohort = 0) AS cohort_customers
    FROM retention
    GROUP BY cohort_month
)
SELECT
    r.cohort_month,
    r.months_since_cohort,
    r.active_customers,
    cs.cohort_customers,
    ROUND(r.active_customers::numeric / NULLIF(cs.cohort_customers, 0), 4) AS retention_rate
FROM retention r
JOIN cohort_size cs
  ON r.cohort_month = cs.cohort_month
ORDER BY r.cohort_month, r.months_since_cohort;
    