--select * from sales_data_sample
--select distinct( ORDERLINENUMBER) from sales_data_sample
--select distinct( PRODUCTLINE) from sales_data_sample
--select distinct(COUNTRY) from sales_data_sample
--select distinct(CITY) from sales_data_sample
--select distinct(YEAR_ID) from sales_data_sample
--select distinct(STATUS) from sales_data_sample


--Total Amount of Sales 
select sum(SALES) as Total_Sales from sales_data_sample
--Total number of orders made 
select count(distinct(ORDERNUMBER)) as No_of_Orders from sales_data_sample

--Month_wise_sales 
select year(orderdate) as Year, month(orderdate) as month, sum(SALES) as monthly_sales from sales_data_sample
group by Year(orderdate), MONTH(orderdate)
order by Year(orderdate), MONTH(orderdate)

--Sales and orders for the first 3 month each year
select year(orderdate), count(distinct( ORDERNUMBER)) as _1QTR_orders, sum(SALES) as _1QTR_sales from sales_data_sample
where month(orderdate) <= 3
group by year(orderdate)


--Quaterly sales
select QTR_ID,sum(sales) as quaterly_sales from sales_data_sample
WHERE YEAR(ORDERDATE) !=2005
group by QTR_ID
ORDER BY quaterly_sales desc
----or this if want proper qtr names 
select case when QTR_ID = 1 then 'FIRST QUARTER' 
when QTR_ID = 2 then 'SECOND QUARTER' 
when QTR_ID = 3 then 'THIRD QUARTER' 
ELSE 'FOURTH QUARTER' END AS QUATER,sum(sales) as quaterly_sales from sales_data_sample
WHERE YEAR(ORDERDATE) !=2005
group by QTR_ID
ORDER BY quaterly_sales desc
----or this if we dont have qtrid
SELECT QUATER, SUM(MONTHLY_sale) FROM
(SELECT MONTH(ORDERDATE) AS MONTH_, CASE WHEN MONTH(ORDERDATE) IN (1,2,3) THEN 'FIRST QUARTER'
WHEN MONTH(ORDERDATE) IN (4,5,6) THEN 'SECOND QUARTER'
WHEN MONTH(ORDERDATE) IN (7,8,9) THEN 'THIRD QUARTER'
ELSE 'FOURTH QUARTER' END AS QUATER,SUM(sales) AS MONTHLY_sale
FROM sales_data_sample
WHERE YEAR(ORDERDATE) !=2005
GROUP BY MONTH( ORDERDATE))q
GROUP BY QUATER
--highest monthly sales 
select top 1
month(orderdate), sum(sales) from sales_data_sample
where year(orderdate) != 2005
group by month(orderdate) 
order by sum(sales) desc
--lowest monthly sales 
select top 1
month(orderdate), sum(sales) from sales_data_sample
where year(orderdate) != 2005
group by month(orderdate) 
order by sum(sales)


--cumalative sales 
With sd AS(SELECT CAST(ORDERDATE as date) AS dates_,ROUND(SUM(sales),2) AS daily_sale 
FROM sales_data_sample
WHERE YEAR(ORDERDATE) !=2005
GROUP BY ORDERDATE)
select dates_, daily_sale, sum(daily_sale)
over(order by dates_ rows between unbounded preceding and current row) Cum_sales
from sd
--This gives an ides on visualizing how cumulative sales curve will vary over date.

--first company which bought the products
with sd as(select  productline, FIRST_VALUE(customername) over(partition by productline order by orderdate) as first_order_of_the_product
from sales_data_sample)
select productline, first_order_of_the_product
from sd
group by productline, first_order_of_the_product

--product sales highest to lowest over the years
select year(orderdate), productline, max(sales) as MAX_sales
from sales_data_sample
group by year(orderdate), productline
order by year(orderdate), PRODUCTLINE

--highest sale of each product ever 
select  productline, max(sales) as MAX_sales
from sales_data_sample
where year(orderdate)!= 2005
group by productline
order by MAX_sales desc