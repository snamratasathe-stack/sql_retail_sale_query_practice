-- sql retail sales analysis -p1 
create database sql_project_p1;
use sql_project_p1;
create table retail_sales(
transactions_id	int ,
sale_date date ,
sale_time	time,
customer_id int ,
	gender	varchar(15),
    age int ,
	category varchar(15),
	quantity int,
	price_per_unit float,
	cogs float,
	total_sale float
);
select * from  retail_sales 
where 
sale_date is null 
or 
sale_time is null 
or 
customer_id is null
or
  age is null
  or 
  category  is null
  or 
  quantity   is null
  or
  price_per_unit  is null
  or
  cogs  is null
  or
total_sale  is null;

select count(*) as total_sale  from retail_sales;
select count(  distinct customer_id) as customers from retail_sales;
select distinct  category from retail_sales;
select count(*) from retail_sales;

-- bussiness and real data analysis problems 
-- write a sql query to retrive all columns for the sales made on '2022-11-05'
select * from retail_sales where sale_date ='2022-11-05';

-- retrive all the transactions where the category is colthing  and qutity sell more than 4 in month of nov-2022
select * from retail_sales where category='Clothing'
and date_format(sale_date,'%Y-%m')='2022-11' 
and   quantity>=4 ;

-- write a sql query to calculate the total sales (total_sale) for each category 
select category, sum(total_sale),count(*)  as total_order from retail_sales group by 1 ;
select avg(age) as avgage  from retail_sales   where category='Beauty';
select * from retail_sales   where total_sale>=1000;
select category,gender,count(transactions_id) as transaction from retail_sales group by category,gender order by  1 ;

SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month, AVG(total_sale) AS avg_sale,
 RANK() OVER ( PARTITION BY YEAR(sale_date) 
 ORDER BY AVG(total_sale) DESC ) AS rnk FROM retail_sales GROUP BY YEAR(sale_date), MONTH(sale_date) 
 ORDER BY year, rnk;
 select  
 year,month,avg_sale
 from(
 SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month, AVG(total_sale) AS avg_sale,
 RANK() OVER ( PARTITION BY YEAR(sale_date) 
 ORDER BY AVG(total_sale) DESC ) AS rnk FROM retail_sales GROUP BY YEAR(sale_date), MONTH(sale_date) 
 ORDER BY year, rnk
 ) as t1 where rnk=1;
 
-- 
select customer_id as customer ,sum(total_sale) as total from retail_sales group by customer_id order by total desc limit 5;
select count( distinct customer_id) as unique_customer,category from retail_sales group by category ;

WITH hourly_sale AS
 ( 
 SELECT *,
 
 CASE WHEN HOUR(sale_time) < 12 THEN 'morning'
 WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
 ELSE 'evening'
 END AS shift FROM retail_sales ) SELECT shift, COUNT(*) as total_orders
 FROM hourly_sale 
 GROUP BY shift;

