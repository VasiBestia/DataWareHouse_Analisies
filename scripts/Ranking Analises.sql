/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/
Use DataWareHouse_Analitics
Go

--Which 5 products generate the highest revenue?
Select Top 5
p.product_name,
Sum(f.sales_amount) As total_revenue
From [gold.fact_sales] f
Left Join [gold.dim_products] p
on p.product_key=f.product_key
Group by p.product_name
Order by total_revenue Desc


--What are the 5 worst performing product in terms of sales?
Select Top 5
p.product_name,
Sum(f.sales_amount) As total_revenue
From [gold.fact_sales] f
Left Join [gold.dim_products] p
on p.product_key=f.product_key
Group by p.product_name
Order by total_revenue 

--Find the top 10 customers who have generated the highest revenue
Select Top 10
c.customer_key,
c.first_name,
c.last_name,
Sum(f.sales_amount) As total_revenue
From [gold.fact_sales] f
Left Join [gold.dim_customers] c
on c.customer_key=f.customer_key
Group by c.customer_key,c.first_name,c.last_name
Order by total_revenue Desc

--Find the top 3 customers with the fewest orders placed
Select Top 3
c.customer_key,
c.first_name,
c.last_name,
Count(Distinct f.order_number) As total_revenue
From [gold.fact_sales] f
Left Join [gold.dim_customers] c
on c.customer_key=f.customer_key
Group by c.customer_key,c.first_name,c.last_name
Order by total_revenue 
