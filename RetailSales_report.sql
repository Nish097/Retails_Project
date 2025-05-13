

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
--and format(CAST(sale_date as date), 'mm-yyyy') = '00-2022'
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

