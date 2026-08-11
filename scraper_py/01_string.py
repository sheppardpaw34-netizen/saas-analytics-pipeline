raw_customer_input = "  99.00_ENTERPRISE_TIER  "
clean_text = raw_customer_input.strip()
lowercase_text = clean_text.lower()
numeric_text = lowercase_text.replace("$","")
parts = numeric_text.split("_",1)
raw_amount = parts[0]
tier_identifier = parts[1]
mrr_amount = float(raw_amount)
print(f"Original Text  : '{raw_customer_input}'")
print(f"Cleaned Text   : '{lowercase_text}'")
print(f"MRR Amount     : {mrr_amount} (Type : {type(mrr_amount)})")
print(f"Tier name      : '{tier_identifier}'")
