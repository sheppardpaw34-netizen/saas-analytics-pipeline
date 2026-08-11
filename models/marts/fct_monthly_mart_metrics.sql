WITH customers_mart AS( SELECT * 
FROM {{ref('dim_customers')}})

SELECT 
SUM (active_mrr) AS total_active_mrr,
COUNT (CASE WHEN customer_status ='active' THEN customer_id END ) AS total_active_customers,
COUNT (CASE WHEN customer_status = 'churned' THEN customer_id END ) AS total_churned_customers,
-- Average revenue per user (ARPU) calculations
ROUND (
    COALESCE (
        SUM(active_mrr)/ NULLIF(COUNT(CASE WHEN customer_status = 'active'THEN customer_id END),0),0),2)AS apru

FROM customers_mart
