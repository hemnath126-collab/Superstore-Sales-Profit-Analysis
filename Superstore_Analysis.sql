Create database super_store;

use super_store;

select * from super_store_analysis
limit 5;

alter table super_store_analysis
modify 
	order_date date,
modify 
	ship_date date,
modify 
	sales decimal(10,2),
modify 
	quantity int,
modify 
	discount decimal(10,2),
modify 
	profit decimal(10,2),
modify 
	shipping_cost decimal(10,2),
modify 
	year year,
modify 
	shipping_days int,
modify 
	profit_margin decimal(10,2);
    
select * from super_store_analysis
limit 5;



# Sales and profit by year
select
	COALESCE(year, 'TOTAL') AS year,
    round(sum(sales),2) as total_sales,
    round(sum(profit),2) as total_profit,
    round(sum(profit)/sum(sales),2) as profit_margin
from super_store_analysis
group by year  WITH ROLLUP;



# Sales and profit by Quarterly 

SELECT 
	year,
    concat('Q', quarter(ship_date)) as quarter,
	round(sum(sales),2) as total_sales,
    round(sum(profit),2) as total_profit,
    round(sum(profit)/sum(sales),2) as profit_margin
from super_store_analysis
group by year, quarter;



# Which segments are most valuable over time
Select *
from (
	Select
		year,
		segment,
		round(sum(sales),2) as total_sales,
		round(sum(profit),2) as total_profit,
		round(sum(profit) / nullif(sum(sales),0),2) as profit_margin,
		Rank() over (partition by  year order by  SUM(profit) DESC) as profit_rank
	from super_store_analysis
	group by year, segment
)t
where profit_rank = 1;



#Top 10 Coustomer by Orders
Select 
	customer_name,
    count(*) As total_orders
from super_store_analysis
group by customer_name
order by total_orders DESC
Limit 10;



# Top 10 Coustomer by sales
Select 
	customer_name,
    round(Sum(sales),2) As total_Sales
from super_store_analysis
group by customer_name
order by total_Sales DESC
Limit 10;


# Top 10 Coustomer by Profit
Select 
	customer_name,
    round(Sum(profit),2) As total_profit
from super_store_analysis
group by customer_name
order by total_profit DESC
Limit 10;


#  High_value and low_value customers

With customer_sales as (
    Select 
        customer_name,
        sum(sales) as total_sales
    From super_store_analysis
    group by  customer_name
)

Select
    case
        When total_sales > 10000 Then 'High_value'
        else 'Low_value'
    end as customer_value,
    sum(total_sales) as total_sales
From customer_sales
group by customer_value;


# Frequent vs one-time buyers

With frequent_summary as(
		select
			customer_name,
			count(*) as order_count
		from super_store_analysis
		group by customer_name
)

Select
	Case
		When order_count > 1 Then "Frequent_buyers"
        Else 'One_time_buyers'
        End as Customer_frequency,
        Count(*) as Frequency_count
From frequent_summary
group by Customer_frequency;


#Find out how many days it will take to reorder 

select 
	round(Avg(days_to_reorder),2)AS days_to_reorder
From(
		select 
			customer_name,
			order_date,
			lag(order_date) 
			over(
				partition by customer_name 
				order by order_date
				)As Previous_order_date ,
			Datediff(
				order_date,
					lag(order_date) 
					over(
						partition by customer_name 
						order by order_date)
					)AS days_to_reorder
		From super_store_analysis
)t;



#Top 5 products by Sales & sub_category
Select
	sub_category,
    product_name,
    sales
From (
		select
			sub_category,
			product_name,
			sum(sales) as sales,
			row_number() over(partition by sub_category order by sum(sales) DESC) AS sales_rank 
		from super_store_analysis
		group by sub_category,product_name
)t
Where sales_rank <= 5;



#Top 5 profitable products by sub_category
Select
	sub_category,
    product_name,
    profit
From (
		select
			sub_category, 
			product_name,
			round(sum(profit),2) as profit,
			row_number() over(partition by sub_category order by sum(profit) DESC) AS profit_rank 
		from super_store_analysis
		group by sub_category,product_name
)t
Where profit_rank <= 5; 



#Top 5 Non-profitable products by sub_category
Select
	sub_category,
    product_name,
    profit
From (
		select
			sub_category,
			product_name,
			round(sum(profit),2) as profit,
			row_number() over(partition by sub_category order by sum(profit)) AS profit_rank 
		from super_store_analysis
		group by sub_category,product_name
)t
Where profit_rank <= 5;


# Top 5 Lowest profit subcategories
Select 
	sub_category,
    sum(profit) profit
from super_store_analysis
Where profit > 0
group by sub_category
order by profit
limit 5;



# Find which subcategories have loss
Select 
	sub_category,
    sum(profit) profit
from super_store_analysis
group by sub_category
Having sum(profit) < 0;


# category wise (orders,sales,profit) by region    
Select
	Region,
	category,
	Count(*) AS total_orders,
	sum(sales) AS total_sales,
	sum(profit) AS total_profit
From super_store_analysis
group by Region,category
order by Region,total_profit Desc;


# Region ranking by profit
 Select
	region,
    round(sum(profit),2) total_profit,
	row_number() over(order by sum(profit) DESC) AS Profit_rank
From super_store_analysis
group by region;



# Which products are consistently top performers in each region
select
	region,
    product_name,
    total_profit
from (	
		select 
			region,
			product_name,
			round(sum(profit),2) total_profit,
			rank() over ( partition by region order by sum(profit) DESC) as product_rank
		from super_store_analysis
		group by region,product_name
)t
where product_rank = 1
order by region;



# Find out which category perform well in region
select *
from(
		select 
			 region,
			 category,
			 rank() over(partition by region order by sum(sales) DESC) as profit_rank
		From super_store_analysis
		group by region, category
)t
Where profit_rank = 1;



# Where are we losing profit despite high sales in region & sub_category 
with region_summary as (
    select
		region,
        sub_category,
        round(sum(sales),2) as total_sales,
        round(sum(profit),2) as total_profit,
        round(sum(profit)/sum(sales),2) as profit_margin
    from super_store_analysis
    group by region,sub_category
)

select *
from region_summary
where profit_margin < 0.1
order by total_sales desc;




# Where are we losing profit 
select
	region
    sub_category,
    segment,
    total_sales,
	total_profit
from (
		select
			region,
			sub_category,
			segment,
			round(sum(sales),2) as total_sales,
			round(sum(profit),2) as total_profit,
			round(sum(profit)/sum(sales),2) as profit_margin
		from super_store_analysis
		group by region, sub_category, segment
)t
Where profit_margin <= 0.1;



# Discount causes loss 
select
	coalesce(discount_bucket,0) as discount,
    round(sum(profit),2) as total_profit
from super_store_analysis
group by discount_bucket
order by discount;



# Did High Shipping_Sost causes loss 
select 
	coalesce(shipping_cost_bucket,"No_cost") as shipping_cost_bucket,
    round(sum(sales),2) as total_sales,
    round(sum(profit),2) as total_profit,
    round(sum(profit)/sum(sales),2) as profit_margin
from super_store_analysis
group by shipping_cost_bucket;




# Which discount + shipping combinations have low margin

With summary as(
	select
		coalesce(discount_bucket,0) as discount_bucket,
		coalesce(shipping_cost_bucket,"No_cost") as shipping_cost_bucket,
		round(sum(sales),2) as total_sales,
		round(sum(profit),2) as total_profit,
		round(sum(profit)/sum(sales),2) as profit_margin
	from super_store_analysis
	group by discount_bucket,shipping_cost_bucket
),

total as(
	select sum(total_sales) as overall_sales 
    from summary
)

Select 
    s.discount_bucket,
    s.shipping_cost_bucket,
    s.total_sales,
    s.total_profit,
    s.profit_margin,
    round(s.total_sales / t.overall_sales,2) as sales_contribution
From summary s
join total t
where 
	s.profit_margin < 0.1 
    and
    s.total_sales >( select AVG(total_sales) From summary) 
order by s.total_sales DESC;