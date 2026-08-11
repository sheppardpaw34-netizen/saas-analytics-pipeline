subscribers = [
    {"customer_id": "cust_101", "mrr": 0.00},
    {"customer_id": "cust_102", "mrr": 29.00},
    {"customer_id": "cust_103", "mrr": 99.00},
    {"customer_id": "cust_104", "mrr": 299.00}
]

for sub in subscribers :
    cust_id = sub["customer_id"]
    mrr = sub["mrr"]
    if mrr == 0.00 :
        tier = "Free tier"
    elif mrr < 50.00 :
        tier = "Starter_tier"
    elif mrr < 100.00 :
        tier = "Pro_tier"
    else:
        tier = "Enterprise Tier"
    print(f"Customer: {cust_id} | MRR: ${mrr:<6.2f} | Assigned Tier: {tier}")
