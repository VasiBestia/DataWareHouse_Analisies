/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/
Use DataWareHouse_Analitics
Go

--Sales Performance Over Time Three Methods

--First Method
Select 
Format(order_date,'yyyy-MMM') As order_month,
Sum(sales_amount) as Total_Sales,
Count(Distinct customer_key) as Total_customrs,
Sum(quantity) As Total_Quantity
From [gold.fact_sales]
Where order_date is not Null
Group by Format(order_date,'yyyy-MMM') 
Order by Format(order_date,'yyyy-MMM') 

--Second Method
Select 
YEAR(order_date) As order_year,
Month(order_date) As order_month,
Sum(sales_amount) as Total_Sales,
Count(Distinct customer_key) as Total_customrs,
Sum(quantity) As Total_Quantity
From [gold.fact_sales]
Where order_date is not Null
Group by YEAR(order_date),Month(order_date) 
Order by YEAR(order_date),Month(order_date)

--Third Method
Select 
Datetrunc(MONTH,order_date) As order_date,
Sum(sales_amount) as Total_Sales,
Count(Distinct customer_key) as Total_customrs,
Sum(quantity) As Total_Quantity
From [gold.fact_sales]
Where order_date is not Null
Group by Datetrunc(MONTH,order_date)
Order by Datetrunc(MONTH,order_date) 