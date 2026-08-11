WITH customers AS (SELECT* FROM {{ref('stg_stripe_customers')}}),
subscriptions AS (SELECT* FROM {{ref('stg_stripe_subscriptions')}})
SELECT
   c.customer_id,
   c.name,
   c.email,
    COALESCE(
        SUM(CASE
        WHEN s.created_at <= CURRENT_TIMESTAMP
        AND (s.canceled_at IS NULL OR s.canceled_at > CURRENT_TIMESTAMP)
        THEN s.mrr
        ELSE 0
        END ) ,0 )AS active_mrr,

        CASE WHEN
                SUM (CASE WHEN s.created_at <= CURRENT_TIMESTAMP
                AND (s.canceled_at IS NULL OR s.canceled_at > CURRENT_TIMESTAMP )
                THEN 1 ELSE 0
                END ) > 0 THEN 'active' ELSE 'churned' END AS customer_status
FROM customers c
LEFT JOIN subscriptions s ON s.customer_id = c.customer_id
GROUP BY 
c.customer_id,
c.name,
c.email
    
    