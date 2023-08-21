-- Key Performance Matrix

--Total revenue of the Company
select 
	sum(total_price) 
	as Revenue 
from pizza_sales;

--Average order price per id
select 
	SUM(total_price) / COUNT(distinct(order_id)) 
	as average_price 
from pizza_sales;

--Total count of Pizza sold
select 
	SUM(quantity) as Total 
from pizza_sales;

--Total Order Recieved
select 
	COUNT(distinct(order_id)) as Total_Order 
from pizza_sales;

--Pizza Count per Order
select 
	cast(cast(sum(quantity) as decimal(10,2)) / CAST(COUNT(distinct(order_id)) as decimal(10,2)) as decimal(10,2)) 
	as avg_pizza_count 
from pizza_sales;

--Hourly trend of Pizza Sales
select 
	DATEPART(HOUR,order_time) as order_hour,
	SUM(quantity) as Total_Pizza_Order
from pizza_sales
Group by DATEPART(HOUR,order_time)
order by DATEPART(HOUR,order_time);

-- Weekly trend For orders
select
	DATEPART(ISO_WEEK,order_date) as Week_Number,
	DATEPART(Year,order_date) as Year,
	count(Distinct(order_id)) as Total
from pizza_sales
Group by 
	DATEPART(ISO_WEEK,order_date),
	DATEPART(Year,order_date)
Order by
	Year, Week_Number;

--Percentage of sales by pizza category
SELECT 
	pizza_category,
	CAST(SUM(total_price) as decimal(10,2)) as total_revenue,
	CAST(SUM(total_price)*100 / 
	(SELECT sum(total_price) from pizza_sales) as decimal(10,2)) as PCT
FROM pizza_sales
Group by pizza_category;

--Percentage of sales by pizza Size

SELECT 
	pizza_size,
	CAST(SUM(total_price) as decimal(10,2)) as total_revenue,
	CAST(SUM(total_price)*100 / 
	(SELECT sum(total_price) from pizza_sales) as decimal(10,2)) as PCT
FROM pizza_sales
Group by pizza_size
order by pizza_size;

--Total Pizza Sold by Pizza Category
select 
	pizza_category ,
	SUM(quantity) as Total
from pizza_sales
group by pizza_category
order by  total desc

--Top 5 Pizza by Revenue
select 
	pizza_name,
	sum(total_price) as Revenue
from pizza_sales
Group by pizza_name
order by Revenue DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

select
	TOP 5
	pizza_name,
	sum(total_price) as Revenue
from pizza_sales
Group by pizza_name
order by Revenue DESC;

--Bottom 5 Pizzas by Revenue
select TOP 5
	pizza_name,
	sum(total_price) as Revenue
from pizza_sales
Group by pizza_name
order by Revenue;

--Top 5 Pizzas by Quantity
Select top 5
	pizza_name,
	sum(quantity) as Total_pizza
from pizza_sales
group by pizza_name
order by Total_pizza DESC;

--Bottom 5 Pizzas by Quantity
select top 5
	pizza_name,
	sum(quantity) as  Total_pizza
from pizza_sales
group by pizza_name
order by Total_pizza asc

--Top 5 Pizzas by Total Order
select top 5 
	pizza_name,
	count(distinct(order_id)) as Total_order
from pizza_sales
group by pizza_name
order by Total_order desc;

--Bottom 5 Pizzas by Total Order
select top 5 
	pizza_name,
	count(distinct(order_id)) as Total_order
from pizza_sales
group by pizza_name
order by Total_order asc;