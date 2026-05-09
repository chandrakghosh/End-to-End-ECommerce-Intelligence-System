DROP TABLE IF EXISTS fact_orders;
DROP TABLE IF EXISTS dim_customers;
DROP TABLE IF EXISTS dim_products;
DROP TABLE IF EXISTS dim_payments;
DROP TABLE IF EXISTS dim_dates;

CREATE TABLE dim_customers(
    customer_id VARCHAR(100) PRIMARY KEY,
    customer_unique_id VARCHAR(100),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

CREATE TABLE dim_products(
    product_category_id INT AUTO_INCREMENT PRIMARY KEY,
    main_product_category VARCHAR(100)
);

CREATE TABLE dim_payments(
    payment_type_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_type VARCHAR(50)
);

CREATE TABLE dim_dates(
    date_id INT AUTO_INCREMENT PRIMARY KEY,
    purchase_year INT,
    purchase_month INT,
    purchase_day INT,
    purchase_day_of_week INT,
    purchase_hour INT,
    purchase_year_month VARCHAR(20)
);

CREATE TABLE fact_orders (
    order_id VARCHAR(100) PRIMARY KEY,
    customer_id VARCHAR(100),
    product_category_id INT,
    payment_type_id INT,
    date_id INT,

    order_status VARCHAR(50),

    purchase_timestamp DATETIME,
    approved_at DATETIME,
    delivered_carrier_date DATETIME,
    delivered_customer_date DATETIME,
    estimated_delivery_date DATETIME,

    delivery_days INT,
    estimated_delivery_days INT,
    delay_days INT,
    is_late INT,

    product_count INT,
    unique_product_count INT,
    seller_count INT,

    total_price DECIMAL(12,2),
    total_freight DECIMAL(12,2),
    avg_price DECIMAL(12,2),
    total_payment DECIMAL(12,2),
    payment_installments INT,

    review_score DECIMAL(4,2),

    FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id),
    FOREIGN KEY (product_category_id) REFERENCES dim_products(product_category_id),
    FOREIGN KEY (payment_type_id) REFERENCES dim_payments(payment_type_id),
    FOREIGN KEY (date_id) REFERENCES dim_dates(date_id)
);

USE ecommerce_intelligence;
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE dim_customers;
TRUNCATE TABLE dim_products;
TRUNCATE TABLE dim_payments;
TRUNCATE TABLE dim_dates;
TRUNCATE TABLE fact_orders;

SET FOREIGN_KEY_CHECKS = 1;

SELECT COUNT(*) FROM dim_customers;
SELECT COUNT(*) FROM dim_products;
SELECT COUNT(*) FROM dim_payments;
SELECT COUNT(*) FROM dim_dates;
SELECT COUNT(*) FROM fact_orders;