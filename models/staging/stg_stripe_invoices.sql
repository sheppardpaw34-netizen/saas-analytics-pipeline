SELECT
    invoice_id,
    subscription_id,
    customer_id,
    amount_due::NUMERIC(10,2) AS amount_due,
    amount_paid::NUMERIC(10,2) AS amount_paid,
    LOWER(status) AS status,
    created_at::TIMESTAMP AS created_at
FROM {{ref('raw_invoices')}}
