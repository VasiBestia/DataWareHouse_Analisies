/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

Use DataWareHouse_Analitics
Go

--Find the date of the first and last order
--How many years of sales are available
Select
Min(order_date) As first_order_date,
Max(order_date) As last_order_date,
DATEDIFF(MONTH,Min(order_date),Max(order_date)) As order_valability
From [gold.fact_sales]

--Find the youngest and the oldest customer
Select
Min(birthdate) As oldest_birthdate,
DATEDIFF(YEAR,Min(birthdate),GETDATE()) As oldest_customer_age,
Max(birthdate) As youngest_birthdate,
DATEDIFF(YEAR,Max(birthdate),GETDATE()) As youngest_customer_age
From [gold.dim_customers]