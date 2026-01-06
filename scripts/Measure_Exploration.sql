/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/
Use DataWareHouse_Analitics
Go

--Find the Total Sales
Select 'Total Sales' As measure_name,SUM(sales_amount) As measure_value
From [gold.fact_sales]
Union All
--Find How many items are sold
Select 'Total Quantity', SUM(quantity)
From [gold.fact_sales]
Union All
--Find the average selling price
Select 'Average Price',Avg(price) 
From [gold.fact_sales]
Union All
--Find The Total number of Orders
Select 'Total Nr. Orders',Count(Distinct order_number) 
From [gold.fact_sales]
Union All
--Find The Total number of products
Select 'Total Nr. Products',Count(Distinct product_key) 
From [gold.dim_products]
Union All
--Find The Total number of customers
Select 'Total Nr. Customers',Count(customer_id) 
From [gold.dim_customers]
Union All
--Find The Total number of customers that has placed an order
Select 'Total Nr. Customers has placed orders',Count(Distinct customer_key)
From [gold.fact_sales]
