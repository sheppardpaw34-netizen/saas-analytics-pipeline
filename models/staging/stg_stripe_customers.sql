SELECT 
    customer_id,
    name,
    email,
    UPPER(country) AS country,
    LOWER(currency) AS currency,
    is_delinquent::BOOLEAN AS is_delinquent,
    created_at::TIMESTAMP AS created_at
FROM {{ref('raw_customers')}}
