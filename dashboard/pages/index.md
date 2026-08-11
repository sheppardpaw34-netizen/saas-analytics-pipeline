# SaaS Business Performance

---

```sql saas_kpis
SELECT 
    total_active_mrr,
    total_active_customers,
    total_churned_customers,
    apru
FROM saas_warehouse.fct_monthly_mart_metrics
```

<Grid cols={4}>
    <BigValue 
        data={saas_kpis} 
        value="total_active_mrr" 
        title="Total Active MRR" 
        fmt="usd" 
    />
    <BigValue 
        data={saas_kpis} 
        value="total_active_customers" 
        title="Active Customers" 
    />
    <BigValue 
        data={saas_kpis} 
        value="total_churned_customers" 
        title="Churned Customers" 
    />
    <BigValue 
        data={saas_kpis} 
        value="apru" 
        title="ARPU" 
        fmt="usd" 
    />
</Grid>

---

## Active & Churned Customer Accounts

```sql customer_list
SELECT 
    customer_id,
    name,
    email,
    active_mrr,
    customer_status
FROM saas_warehouse.dim_customers
ORDER BY active_mrr DESC
```

<DataTable data={customer_list} search={true} pagination={true} pagesize={10}>
    <Column id="customer_id" title="Customer ID" />
    <Column id="name" title="Name" />
    <Column id="email" title="Email" />
    <Column id="active_mrr" title="MRR" fmt="usd" />
    <Column id="customer_status" title="Status" />
</DataTable>