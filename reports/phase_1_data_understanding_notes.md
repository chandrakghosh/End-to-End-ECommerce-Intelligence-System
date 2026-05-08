# Phase 1: Data Understanding Notes

## Dataset Used
Brazilian E-Commerce Public Dataset by Olist

## Number of Tables
9 CSV files

## Main Tables
- customers
- orders
- order_items
- order_payments
- order_reviews
- products
- sellers
- geolocation
- product_category_name_translation

## Initial Observations
- orders and customers both have 99,441 rows.
- order_items has more rows because one order can contain multiple products.
- order_payments has more rows because one order can have multiple payment records.
- geolocation is the largest table with more than 1 million rows.
- product category names are in Portuguese and need translation.

## Next Step
Create clean and analysis-ready datasets:
- order-level dataset
- customer-level dataset
- product/seller-level dataset