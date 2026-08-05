SELECT 
    subscription_id,
    customer_id,
    plan_name,
    mrr :: NUMERIC(10,2) AS mrr,
    LOWER(status) AS status,
    created_at::TIMESTAMP AS created_at,
    canceled_at::TIMESTAMP AS canceled_at 
FROM {{ref('raw_subscriptions')}}