

use cancer





-- Data Cleaning
SELECT * FROM RetailSales_Analysis
WHERE transactions_id IS NULL

SELECT * FROM RetailSales_Analysis
WHERE sale_date IS NULL

SELECT * FROM RetailSales_Analysis
WHERE sale_time IS NULL

SELECT * FROM RetailSales_Analysis
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;


	-- 
DELETE FROM RetailSales_Analysis
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    




	
-- How many sales we have?
SELECT COUNT(*) as total_sale FROM RetailSales_Analysis

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM RetailSales_Analysis



SELECT DISTINCT category FROM RetailSales_Analysis



-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)




select * from RetailSales_Analysis

 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from RetailSales_Analysis
where sale_date='5/11/2022'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select * from RetailSales_Analysis
where category='Clothing'
and quantiy >=4 
and month(sale_date)='11' and year(sale_date)='2022'



/** select sale_date from RetailSales_Analysis


with cte as
(
select format(CAST(sale_date as date), 'mm/yyyy') as date from RetailSales_Analysis
 where format(CAST(sale_date as date), 'mm-yyyy') = '00-2023'
where category='Clothing'
and quantiy >=4 ) 

select * from cte
where date = '11-2022'**/


--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select sum(cast(total_sale as float)) as net_sales , category
from RetailSales_Analysis
group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select avg(cast(age as int)) as cust_age 
from RetailSales_Analysis
where category='Beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from RetailSales_Analysis
where total_sale >1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select sum(cast(transactions_id as int)) as total_trans,
gender, category
from RetailSales_Analysis
group by gender, category


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
with bestselling as (
                      select avg(cast(total_sale as float)) as avg_sale,
                      year(sale_date) as years, month(sale_date) as months
                      from RetailSales_Analysis
                      group by month(sale_date), year(sale_date)
					  ),
					 RANKTOPSALE as (
					                  select *,
					                 rank() over (partition by years order by avg_sale desc) as topmonth
									 from bestselling
									 )
									  select years ,months,
									  round(avg_sale ,2)
									  from RANKTOPSALE 
									  where topmonth=1


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sale

    -- 1st method

	 select top 5 customer_id,
	 sum(cast(total_sale as int)) as net_sale
	 from RetailSales_Analysis
	 group by customer_id
	 order by net_sale desc


----2nd method

	 with netSale as(
	 select sum(cast(total_sale as int)) as net_sale,
	 customer_id
	 from RetailSales_Analysis
	 group by customer_id
	 ) ,
	 rankcustomer as
	 (
	 select  *,
	 rank() over(order by net_sale desc) as SalesRank
	 from netSale
	 )
	 select customer_id,
	 net_sale,
	 SalesRank
	 from rankcustomer
	 where SalesRank<=5


 -- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

 select count(distinct customer_id) as uniquecustomer, category
 from RetailSales_Analysis
 group by category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


with hourlysale as
(
  select 
  case
  when DATEPART(hour,sale_date) <=12 then 'Morning'
  when DATEPART(hour,sale_date) between 12 and 17 then 'Afternoon'
  else 'Evening'
  end as shift
  from RetailSales_Analysis
  )
  select
  count(*) as total_orders
  from hourlysale 
  group by shift


  ---- Project end-----
  

