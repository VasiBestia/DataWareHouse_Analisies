/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/
Use DataWareHouse_Analitics
Go

--Calculate the total sales per month and the 
--running total of sales over time
Select
order_month,
Total_Sales,
Avg_Price,
Sum(Total_Sales) Over(Partition by Year(order_month) Order by order_month) As running_total_sales,
Avg(Avg_Price) Over(Partition by Year(order_month) Order by order_month) As moving_avg_price
From(
Select 
Datetrunc(month,order_date) As order_month,
Sum(sales_amount) as Total_Sales,
Avg(price) as Avg_Price
From [gold.fact_sales]
Where order_date is not Null
Group by Datetrunc(month,order_date)
) t 