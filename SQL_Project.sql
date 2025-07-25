Create Database sql_project; # Database created
use sql_project;   # Accesing database

#Table Creation
create Table Retail_sales
          (
           transactions_id	int primary key,
           sale_date	Date,
           sale_time	Time,
           customer_id	int,
           gender	varchar(15),
           age	int,
           category	varchar(16),
           quantiy	int,
           price_per_unit	float,
           cogs	float,
           total_sale  float
           )
           
select * from retail_sales;

#Checking Null values in each column
 select * from retail_sales
 where transactions_id is Null
       or
       sale_date is Null
       or
       sale_time  is Null
       or
       customer_id  is Null
       or
       gender   is Null
       or
       age  is Null
       or
       category is Null
       or
       quantiy  is Null
       or
       price_per_unit  is Null
       or
       cogs   is Null
       or
       total_sale  is Null;
       

# sql query for checking unique customers in data
 select 
     count(distinct(customer_id)) 
     from retail_sales;
 
 #sql query for  Checking  distinct or different  categories in data
 Select 
      Count(distinct(category)) As No_of_categories 
      from retail_sales;
 
 select 
   distinct(category) from retail_sales;
 
 #query retrive date on specific date like 2022-11-05
 select * from retail_sales 
 where sale_date = '2022-11-05';
 
 #Retrive date where category is "Clothing" and quantity sold by more than 4 and  date is 2022-11.
select * from retail_sales
where
    category = 'Clothing' AND
    date_format(sale_date,  '%Y-%m') ='2022-11' AND
    quantiy >'3'
    order by transactions_id;
    
#query for to retrive total sales on each category
select category,
sum(total_sale) as Total_sales,
count(*) as Total_orders
from retail_sales 
Group by category;
    
 #query to retrive where category is Beauty with an average age 
select 
round(avg(age),2) as Average_age
 from  retail_sales 
 where 
category ='Beauty';

#retriving date where total sales is greater than 1000..?
select *
from retail_sales 
where 
total_sale >= 1000;

#sql query for total transactions for each category
select category, 
       gender,
       count(*) as total_trans
from retail_sales
group by category, 
       gender;
       
#sql query for average sale on year and month  and best month of average sale      
WITH monthly_avg AS (
  SELECT 
    YEAR(sale_date) AS sale_year,
    MONTH(sale_date) AS sale_month,
    AVG(total_sale) AS average_sale
  FROM retail_sales
  GROUP BY YEAR(sale_date), MONTH(sale_date))
SELECT 
  sale_year,
  sale_month,
  average_sale,
  RANK() OVER (PARTITION BY sale_year ORDER BY average_sale DESC) AS sale_rank
FROM monthly_avg
ORDER BY sale_year, average_sale DESC;

          
# SQL query for top 5 customers based on highest sales         
select customer_id,
      sum(total_sale) as Total
 from retail_sales
 group by customer_id
 order by Total Desc
  limit 5;
  
 
 #query for unique customers who purchased on each category
 select 
     category,
    count(Distinct customer_id) as Unique_customers
 from retail_sales
 Group by category;


#sql query if time below 12 then Morning and time between 12 - 17 then Afternoon .Incase both are false then EVENING
select *,
   CASE
    when Extract(HOUR FROM sale_time) < 12 Then 'MORNING'
    when Extract(HOUR FROM sale_time) Between 12 AND 17 Then 'AFTERNOON'
    ELSE 'EVENING'
END as Purchasing_Shifts
from retail_sales


