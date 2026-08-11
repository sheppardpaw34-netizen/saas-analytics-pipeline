def categorize_subscription (cust_id,mrr_amount):
    clean_mrr = float(mrr_amount)
    if clean_mrr == 0:
        tier = "Free Tier"
    elif clean_mrr < 50.00:
        tier = "Starter Tier"
    elif clean_mrr < 100.00:
        tier = "Enterprise Tier"
    else: 
        tier = "Pro_tier"
    return {
        "account_id": cust_id.upper(),
        "mrr" : clean_mrr,
        "assigned_tier" : tier
    }
record_1 = categorize_subscription("cust_201","0.00")
record_2 = categorize_subscription("cust_301",149.50)
print(f"Record 01  : {record_1}")
print(f"Record 02  : {record_2}")

