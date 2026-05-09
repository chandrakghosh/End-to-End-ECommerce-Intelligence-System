SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(total_payment), 2) AS total_revenue,
    ROUND(AVG(total_payment), 2) AS avg_order_value,
    ROUND(AVG(review_score), 2) AS avg_review_score,
    ROUND(AVG(is_late) * 100, 2) AS late_delivery_rate,
    ROUND(AVG(delivery_days), 2) AS avg_delivery_days
FROM fact_orders;


SELECT
    d.purchase_year_month,
    COUNT(DISTINCT f.order_id) AS total_orders,
    ROUND(SUM(f.total_payment), 2) AS total_revenue,
    ROUND(AVG(f.total_payment), 2) AS avg_order_value
FROM fact_orders f
JOIN dim_dates d
    ON f.date_id = d.date_id
GROUP BY d.purchase_year_month
ORDER BY d.purchase_year_month;


SELECT
    c.customer_state,
    COUNT(DISTINCT f.order_id) AS total_orders,
    ROUND(SUM(f.total_payment), 2) AS total_revenue,
    ROUND(AVG(f.total_payment), 2) AS avg_order_value,
    ROUND(AVG(f.review_score), 2) AS avg_review_score
FROM fact_orders f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;


SELECT
    p.main_product_category,
    COUNT(DISTINCT f.order_id) AS total_orders,
    ROUND(SUM(f.total_payment), 2) AS total_revenue,
    ROUND(AVG(f.review_score), 2) AS avg_review_score,
    ROUND(AVG(f.is_late) * 100, 2) AS late_delivery_rate
FROM fact_orders f
JOIN dim_products p
    ON f.product_category_id = p.product_category_id
GROUP BY p.main_product_category
ORDER BY total_revenue DESC
LIMIT 15;


SELECT
    c.customer_state,
    COUNT(DISTINCT f.order_id) AS total_orders,
    ROUND(AVG(f.is_late) * 100, 2) AS late_delivery_rate,
    ROUND(AVG(f.delay_days), 2) AS avg_delay_days,
    ROUND(AVG(f.review_score), 2) AS avg_review_score
FROM fact_orders f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY c.customer_state
HAVING total_orders >= 100
ORDER BY late_delivery_rate DESC;


SELECT
    p.payment_type,
    COUNT(DISTINCT f.order_id) AS total_orders,
    ROUND(SUM(f.total_payment), 2) AS total_revenue,
    ROUND(AVG(f.total_payment), 2) AS avg_order_value,
    ROUND(AVG(f.review_score), 2) AS avg_review_score
FROM fact_orders f
JOIN dim_payments p
    ON f.payment_type_id = p.payment_type_id
GROUP BY p.payment_type
ORDER BY total_revenue DESC;


SELECT
    CASE
        WHEN is_late = 1 THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(review_score), 2) AS avg_review_score,
    ROUND(AVG(delivery_days), 2) AS avg_delivery_days,
    ROUND(AVG(delay_days), 2) AS avg_delay_days
FROM fact_orders
GROUP BY delivery_status;


WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT f.order_id) AS total_orders,
        SUM(f.total_payment) AS total_spent
    FROM fact_orders f
    JOIN dim_customers c
        ON f.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    CASE
        WHEN total_orders > 1 THEN 'Repeat Customer'
        ELSE 'One-Time Customer'
    END AS customer_type,
    COUNT(*) AS customer_count,
    SUM(total_orders) AS total_orders,
    ROUND(SUM(total_spent), 2) AS total_revenue,
    ROUND(AVG(total_spent), 2) AS avg_customer_spend
FROM customer_orders
GROUP BY customer_type;


SELECT
    CASE
        WHEN review_score <= 2 THEN 'Bad Review'
        WHEN review_score = 3 THEN 'Neutral Review'
        ELSE 'Good Review'
    END AS review_group,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(total_payment), 2) AS avg_order_value,
    ROUND(AVG(delivery_days), 2) AS avg_delivery_days,
    ROUND(AVG(is_late) * 100, 2) AS late_delivery_rate
FROM fact_orders
GROUP BY review_group
ORDER BY total_orders DESC;


SELECT
    c.customer_state,
    COUNT(DISTINCT f.order_id) AS total_orders,
    ROUND(SUM(f.total_payment), 2) AS total_revenue,
    ROUND(AVG(f.review_score), 2) AS avg_review_score,
    ROUND(AVG(f.is_late) * 100, 2) AS late_delivery_rate
FROM fact_orders f
JOIN dim_customers c
    ON f.customer_id = c.customer_id
GROUP BY c.customer_state
HAVING total_orders >= 500
ORDER BY total_revenue DESC, avg_review_score DESC;