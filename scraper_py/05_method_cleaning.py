import pandas as pd 
raw_subscriptions = pd.DataFrame(
    {
        "customer_id": ["cus_101","cus_102","cus_103","cus_104","cus_105"],
        "plan_type"  : ["starter","enterprise","pro","enterprise","PRO"],
        "monthly_amount":[500,49,0,49,1000],
        "status" : ["active","active","failed","active","active"],
        "region" :["EU","US","US","EU","US"]
        
    }
)
print("==RAW DATA==")
print(raw_subscriptions)
print("\n")

cleaned_data = (
    raw_subscriptions
    .assign(plan_type= lambda x:x["plan_type"].str.strip().str.lower())
    .query("status =='active' and monthly_amount>0")
    .assign(annual_revenue =lambda x:x["monthly_amount"]*12)
    .drop(columns=["status"])
    )
print("===Cleaned_data===(method chaining)")
print(cleaned_data)
plan_summary = (
    cleaned_data
    .groupby(["region","plan_type"])
    .agg(
        total_mrr = ("monthly_amount","sum"),
        total_arr = ("annual_revenue","sum"),
        avr_mrr_per_users = ("monthly_amount","mean"),
        active_subscriber = ("customer_id","count"),

    )
    .reset_index()

)
print("===FINAL SAAS METRIC SUMMERY===")
print(plan_summary)
