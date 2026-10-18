
/*
====================================================
PROJECT: Bank Marketing Campaign Analysis
PURPOSE: Analyze customer subscription behavior
TOOLS: MySQL
DATASET: Bank Marketing (41,188 contact records)
====================================================
*/

USE Banking_Data;


-- ============================================
-- 1. DATA QUALITY CHECKS
-- ============================================

-- Check total number of records
SELECT COUNT(*) AS total_rows
FROM banking;

-- Preview the first 5 records
SELECT *
FROM banking
LIMIT 5;

-- Check column names and data types
DESCRIBE banking;

-- Check for missing values in key columns
SELECT
    SUM(age IS NULL) AS missing_age,
    SUM(job IS NULL) AS missing_job,
    SUM(contact IS NULL) AS missing_contact,
    SUM(y IS NULL) AS missing_outcome
FROM banking;


-- ============================================
-- 2. EXPLORATORY DATA ANALYSIS
-- ============================================

-- Analyze subscription outcomes
SELECT
    y AS outcome,
    COUNT(*) AS total_contacts
FROM banking
GROUP BY y;


-- ============================================
-- 3. BASELINE CAMPAIGN PERFORMANCE
-- -- Business question:
-- What percentage of contacts resulted in a subscription?
-- ============================================

SELECT
    y AS outcome,
    COUNT(*) AS total_contacts,
    ROUND( COUNT(*) * 100.0 /(SELECT COUNT(*) FROM banking),2) AS percentage
FROM banking
GROUP BY y;

-- ============================================
-- 4. CONVERSION RATE ANALYSIS
-- Business question:
-- Which audience segments have higher conversion?
-- ============================================

-- Conversion rate by job type
SELECT
    job,
    COUNT(*) AS total_contacts,
    SUM(y = 'yes') AS subscriptions,
    ROUND(AVG(y = 'yes') * 100, 2) AS conversion_rate_pct
FROM banking
GROUP BY job
ORDER BY conversion_rate_pct DESC;


-- Conversion rate by education
SELECT
    education,
    COUNT(*) AS total_contacts,
    SUM(y = 'yes') AS subscriptions,
    ROUND(AVG(y = 'yes') * 100, 2) AS conversion_rate_pct
FROM banking
GROUP BY education
ORDER BY conversion_rate_pct DESC;


-- Conversion rate by marital status
SELECT
    marital,
    COUNT(*) AS total_contacts,
    SUM(y = 'yes') AS subscriptions,
    ROUND(AVG(y = 'yes') * 100, 2) AS conversion_rate_pct
FROM banking
GROUP BY marital
ORDER BY conversion_rate_pct DESC;


-- Conversion rate by age group
SELECT
    CASE
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS total_contacts,
    SUM(y = 'yes') AS subscriptions,
    ROUND(AVG(y = 'yes') * 100, 2) AS conversion_rate_pct
FROM banking
GROUP BY age_group
ORDER BY conversion_rate_pct DESC;


-- ============================================
-- 5. CAMPAIGN PERFORMANCE ANALYSIS
-- Business question:
-- How do campaign strategies relate to
-- subscription conversion?
-- ============================================

-- Query 1: Conversion rate by current campaign
-- contact frequency
SELECT
    campaign AS number_of_contacts,
    COUNT(*) AS total_records,
    SUM(y = 'yes') AS subscriptions,
    ROUND(AVG(y = 'yes') * 100, 2) AS conversion_rate_pct
FROM banking
GROUP BY campaign
ORDER BY campaign;


-- Query 2: Conversion rate by previous campaign
-- outcome
SELECT
    poutcome AS previous_campaign_outcome,
    COUNT(*) AS total_records,
    SUM(y = 'yes') AS subscriptions,
    ROUND(AVG(y = 'yes') * 100, 2) AS conversion_rate_pct
FROM banking
GROUP BY poutcome
ORDER BY conversion_rate_pct DESC;


-- Query 3: Conversion rate by contact method
SELECT
    contact AS contact_method,
    COUNT(*) AS total_records,
    SUM(y = 'yes') AS subscriptions,
    ROUND(AVG(y = 'yes') * 100, 2) AS conversion_rate_pct
FROM banking
GROUP BY contact
ORDER BY conversion_rate_pct DESC;


-- Query 4: Conversion rate by contact month
SELECT
    month AS contact_month,
    COUNT(*) AS total_records,
    SUM(y = 'yes') AS subscriptions,
    ROUND(AVG(y = 'yes') * 100, 2) AS conversion_rate_pct
FROM banking
GROUP BY month
ORDER BY conversion_rate_pct DESC;


-- Query 5: Conversion rate by day of week
SELECT
    day_of_week,
    COUNT(*) AS total_records,
    SUM(y = 'yes') AS subscriptions,
    ROUND(AVG(y = 'yes') * 100, 2) AS conversion_rate_pct
FROM banking
GROUP BY day_of_week
ORDER BY conversion_rate_pct DESC;

-- ============================================
-- 6. FACTOR COMPARISON ANALYSIS
-- Business question:
-- How does conversion vary across combinations
-- of customer and campaign characteristics?
-- ============================================

-- Query 1: Conversion rate by month and contact
-- method
SELECT
    month AS contact_month,
    contact AS contact_method,
    COUNT(*) AS total_records,
    SUM(y = 'yes') AS subscriptions,
    ROUND(AVG(y = 'yes') * 100, 2) AS conversion_rate_pct
FROM banking
GROUP BY month, contact
ORDER BY month, conversion_rate_pct DESC;

-- Conversion rate by month and contact method
-- Only include groups with 1,000+ records
SELECT
    month AS contact_month,
    contact AS contact_method,
    COUNT(*) AS total_records,
    SUM(y = 'yes') AS subscriptions,
    ROUND(AVG(y = 'yes') * 100, 2) AS conversion_rate_pct
FROM banking
GROUP BY month, contact
HAVING COUNT(*) >= 1000
ORDER BY month, conversion_rate_pct DESC;

-- Query 2: Conversion rate by number of previous
-- campaign contacts

SELECT
    previous AS previous_contacts,
    COUNT(*) AS total_records,
    SUM(y = 'yes') AS subscriptions,
    ROUND(AVG(y = 'yes') * 100, 2) AS conversion_rate_pct
FROM banking
GROUP BY previous
ORDER BY previous;


-- Query 3: Conversion rate by age group and
-- contact method
SELECT
    CASE
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,
    contact AS contact_method,
    COUNT(*) AS total_records,
    SUM(y = 'yes') AS subscriptions,
    ROUND(AVG(y = 'yes') * 100, 2) AS conversion_rate_pct
FROM banking
GROUP BY age_group, contact
ORDER BY age_group, conversion_rate_pct DESC;

-- Query 3: Conversion Rate by Age Group and Contact Method
-- Only include groups with 1,000+ records

SELECT
    CASE
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,
    contact AS contact_method,
    COUNT(*) AS total_records,
    SUM(y = 'yes') AS subscriptions,
    ROUND(AVG(y = 'yes') * 100, 2) AS conversion_rate_pct
FROM banking
GROUP BY age_group, contact
HAVING COUNT(*) >= 1000
ORDER BY age_group, conversion_rate_pct DESC;