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

