subscription_plans = ["stater_tier","pro_tier","enterprize_tier"]
first_plan = subscription_plans [0]
last_plan = subscription_plans [-1]
subscription_plans.append("customer_tier")
customer_record = {
    "customer_id" : "cust_02",
    "plan_name"   : "pro_tier",
    "mrr_amount"  : 99.99,
    "is_active"   : True
}
current_mrr = customer_record["mrr_amount"]
customer_record["currency"] = "USD"
customer_record["mrr_amount"] = 199.99

print(f"All Plans    : {subscription_plans}")
print(f"First Plans  : {first_plan}")
print(f"Update Plan  : {last_plan}")
print("----")
print(f"Customer_ID : {customer_record['customer_id']}")
print(f"Update MRR  : {customer_record['mrr_amount']}{customer_record['currency']}")
print(f"Full Record  : {customer_record}")