# Bank Marketing Campaign Analysis

## Project Overview

This project analyzes 41,188 bank marketing campaign records to identify patterns in customer subscriptions and campaign performance. Using MySQL and Tableau Public, I explored conversion rates across customer segments, contact methods, and campaign characteristics to identify audiences with higher response rates and opportunities to improve marketing effectiveness.

## Business Questions

* Which customer job categories have the highest conversion rates?
* How do conversion rates differ by contact method?
* How does the outcome of a previous campaign relate to customer response?
* How does conversion vary across campaign months?

## Tools Used

* **MySQL:** Data quality checks, exploratory data analysis, aggregations, and conversion-rate calculations.
* **Tableau Public:** KPI development and interactive dashboard visualization.

## Key Findings

* **Overall conversion rate:** 11.27%, with 4,640 subscriptions from 41,188 campaign contacts.
* **Job category:** Students had a 31.43% conversion rate, while retired customers had a 25.23% conversion rate.
* **Contact method:** Cellular contacts converted at 14.74%, compared to 5.23% for telephone contacts.
* **Previous campaign outcome:** Customers with a previously successful campaign outcome had a 65.11% conversion rate, compared to 14.23% for previous failures and 8.83% for Customers with no previous outcome.

## Tableau Dashboard

**[View the interactive Bank Marketing Campaign Analysis dashboard on Tableau Public](https://public.tableau.com/app/profile/oscar.canales/viz/BankingMArketingCampaignAnalysis/BankMarketingCampaignAnalysis?publish=yes)**

## Dataset

This project uses the UCI Bank Marketing dataset, which contains customer demographics, campaign contact information, and subscription outcomes from a bank's direct marketing campaigns. The campaign promoted a bank term-deposit product.

## Repository Contents

* `bank_marketing_analysis.sql` — SQL queries for data quality checks, exploratory analysis, and campaign performance comparisons.
* `sql-conversion-by-job.png` — Screenshot of the SQL query and results.
* `bank-marketing-dashboard.png`
