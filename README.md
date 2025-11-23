# Task 6 – Sales Trend Analysis Using Aggregations

This repository contains my solution for Task 6 of the Data Analyst Internship program.

## Objective
To analyze monthly revenue and order volume using SQL aggregate functions.

## Dataset
Table: online_sales  
Columns used:
- order_date
- amount
- order_id
- product_id

## SQL Functions Used
- EXTRACT(MONTH FROM order_date)
- EXTRACT(YEAR FROM order_date)
- SUM(amount)
- COUNT(DISTINCT order_id)
- GROUP BY
- ORDER BY
- LIMIT

## Files
- task6.sql – SQL script for analysis
- results.csv – Output table with monthly revenue and order volume

## Sample Insight
- The month with the highest revenue was one of the top 3 months based on SUM(amount)
- Order count was calculated using COUNT(DISTINCT order_id)
- Monthly trends were generated using EXTRACT(YEAR FROM order_date) and EXTRACT(MONTH FROM order_date)
