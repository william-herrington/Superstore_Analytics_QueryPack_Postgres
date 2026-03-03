# Superstore Analytics Query Pack (PostgreSQL)

## Project Overview
This project demonstrates advanced SQL analytics techniques in PostgreSQL using a structured, production-style ETL workflow.

The objective was to ingest raw transactional data, perform structured data validation and transformation, and apply business-oriented analytical queries using CTEs and window functions.

**Pipeline:**   
Raw → Profiling → Stage → Clean → Feature Engineering → Analytics Query Pack  

This layered architecutre preserves raw data integrity while enabling safe transformation and scalable analytical querying.

---

## Architecture Diagram

```mermaid
flowchart LR
    A[CSV Dataset]
    --> B[RAW: superstore_raw<br/>All fields stored as TEXT]
    --> C[PROFILING: Missing checks, duplicates, format validation]
    --> D[STAGE: Clean & Cast<br/>Trim + regex cleansing + typed casting]
    --> E[CLEAN: superstore_clean<br/>Validated analytics table]
    --> F[FEATURES<br/>sales_bucket]
    --> G[ANALYTICS QUERY PACK<br/>Rolling metrics + ranking + cohorts]
```

--- 

## Tools Used

- PostgreSQL
- pgAdmin
- SQL
- VS Code
- GitHub

--- 

## Dataset Summary

- Raw rows ingested: **9,800**
- Clean rows produced: **9,800**

The dataset includes: 

- Orders (order_id, order_date, ship_date, ship_mode)
- Customers (customer_id, segment, region)
- Products (category, sub_category, product_name)
- Sales (sales)

---

## Screenshots

### Raw import row count: 

![Raw Row Count](./IMAGES/03_raw_row_count.png)

### Profiling outputs: 

![Profiling Missing Values](./IMAGES/04_profiling_missing_values.png)
![Category Distribution](./IMAGES/05_category_distribution.png)

### Stage validation: 

![Stage Cast Validation](./IMAGES/07_stage_cast_validation.png)

### Clean row count: 

![Clean Row Count](./IMAGES/08_clean_row_count.png)

### Feature preview: 

![Feature Preview](./IMAGES/09_feature_preview.png)

### Rolling metrics: 

![Rolling Metrics](./IMAGES/10_rolling_metrics.png)

### Product ranking: 

![Top Products](./IMAGES/11_top_products.png)

### Cohort retention: 

![Cohort Retention](./IMAGES/12_cohort_retention.png)

---

## Analytics Queries Included

All queries are written using Common Table Expressions (CTEs) and window fucntions to demonstrate production-level analytical SQL patterns.

**1. Rolling 7- and 30-day sales**

Business question: "How are daily sales trending over time?"

**2. Top 10 products by sales (ranking)**

Business question: "Which products generate the most sales?"

**3. Cohort retention (monthly)**

Business question: "Do customers return in later months after their first purchase month?"

---

## Repo Structure

```
DATA/  
IMAGES/ 
SQL/  
README.md  
```