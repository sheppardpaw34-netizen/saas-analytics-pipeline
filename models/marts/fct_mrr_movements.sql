WITH date_spine AS (
    SELECT
        CAST(generate_series AS DATE) AS date_month
    FROM generate_series(
        DATE '2023-01-01',
        DATE '2026-12-31',
        INTERVAL '1 month'
    )
),

subscriptions_period AS (
    SELECT
        customer_id,
        plan_name,
        subscription_id,
        mrr AS mrr_amount,
        date_trunc('month', created_at)::DATE AS start_month,
        date_trunc('month', COALESCE(canceled_at, '2099-12-31'::DATE))::DATE AS end_month,
        (date_trunc('month', COALESCE(canceled_at, '2099-12-31'::DATE))::DATE + INTERVAL '1 month')::DATE AS extended_end_month,
        status
    FROM {{ ref("stg_stripe_subscriptions") }}
),
customer_monthly_mrr AS (
    SELECT
        sp.customer_id,
        sp.plan_name,
        sp.subscription_id,
        d.date_month AS mrr_month,
        SUM(sp.mrr_amount) AS current_mrr
    FROM subscriptions_period sp
    INNER JOIN date_spine d
        ON d.date_month >= sp.start_month
       AND d.date_month <= (sp.end_month + INTERVAL '1 month')::DATE
    GROUP BY 1, 2, 3, 4
),

mrr_with_lag as (
    SELECT 
    customer_id,
    subscription_id,
    plan_name,
    mrr_month,
    current_mrr,
    lag(current_mrr,1,0.00)
OVER (PARTITION BY subscription_id
ORDER BY mrr_month) AS previous_mrr
FROM customer_monthly_mrr
),

mrr_movement AS (
    SELECT
        customer_id,
        subscription_id,
        plan_name,
        mrr_month,
        previous_mrr,
        current_mrr,
        (current_mrr - previous_mrr) AS mrr_change,

        -- New Subscription
        CASE 
            WHEN previous_mrr = 0 AND current_mrr > 0 THEN current_mrr 
            ELSE 0 
        END AS new_mrr,

        -- Expansion (Upgrade)
        CASE 
            WHEN previous_mrr > 0 AND current_mrr > previous_mrr THEN (current_mrr - previous_mrr) 
            ELSE 0 
        END AS expansion_mrr,

        -- Contraction (Downgrade)
        CASE 
            WHEN previous_mrr > 0 AND current_mrr < previous_mrr AND current_mrr > 0 THEN (previous_mrr - current_mrr) 
            ELSE 0 
        END AS contraction_mrr,

        -- Churn (Full Cancellation)
        CASE 
            WHEN previous_mrr > 0 AND current_mrr = 0 THEN previous_mrr 
            ELSE 0 
        END AS churn_mrr
    FROM mrr_with_lag
)

SELECT
    customer_id,
    subscription_id,
    plan_name,
    mrr_month,
    previous_mrr,
    current_mrr,
    mrr_change,
    new_mrr,
    expansion_mrr,
    contraction_mrr,
    churn_mrr
FROM mrr_movement