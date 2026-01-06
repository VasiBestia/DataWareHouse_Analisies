/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/
Use DataWareHouse_Analitics
Go

/*Analyze the yearly performance of products by comparing each 
  products sales to both its avg sales performance and the 
  previous years sales*/
With yearly_products As(
Select
Year(f.order_date) as order_year,
p.product_name,
Sum(f.sales_amount) as current_sales
From [gold.fact_sales] f
Left Join [gold.dim_products] p
on f.product_key=p.product_key
Where f.order_date is not null
Group by Year(f.order_date) ,
p.product_name
)

Select
order_year,
product_name,
current_sales,
AVG(current_sales) Over(Partition by product_name) As avg_sales,
current_sales-AVG(current_sales) Over(Partition by product_name) As diff_avg,  
Case When current_sales-AVG(current_sales) Over(Partition by product_name)<0 Then 'Below Avg'
     When current_sales-AVG(current_sales) Over(Partition by product_name)>0 Then 'Above Avg'
     Else 'Avg'
End flag_about_avg,
Lag(current_sales) Over(Partition by product_name order by order_year) As previous_year_sales,
current_sales -Lag(current_sales) Over(Partition by product_name order by order_year) As diff_previous_year_sales,
Case When current_sales-Lag(current_sales) Over(Partition by product_name Order by order_year)<0 Then 'Decrease'
     When current_sales-Lag(current_sales) Over(Partition by product_name Order by order_year)>0 Then 'Increase'
     Else 'No Change'
End flag_about_py
From yearly_products
Order by product_name,order_year