/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/
Use DataWareHouse_Analitics
Go

--Which categories contribute the most to overall sales
With category_sales As(
Select 
category,
Sum(sales_amount) as total_sales
From [gold.fact_sales] f
Left Join [gold.dim_products] p
on f.product_key=p.product_key
Group by category
)
Select 
category,
total_sales,
Sum(total_sales) Over() overall_sales,
Concat(Round((Cast(total_sales as float)/Sum(total_sales) Over())*100,2),'%') As percentage_pie
From category_sales
Order by total_sales Desc