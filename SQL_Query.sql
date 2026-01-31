CREATE DATABASE Retail_Sales_Analysis_SQL_Project;

USE Retail_Sales_Analysis_SQL_Project;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

SELECT * FROM retail_sales LIMIT 100;

SELECT COUNT(*) FROM retail_sales;

--Data Cleaning
SELECT *
FROM retail_sales
WHERE
    transactions_id is null
    or sale_date is null
    or sale_time is null
    or customer_id is null
    or gender is null
    or age is null
    or category is null
    or quantity is null
    or price_per_unit is null
    or cogs is null;

DELETE FROM retail_sales
WHERE
    transactions_id is null
    or sale_date is null
    or sale_time is null
    or customer_id is null
    or gender is null
    or age is null
    or category is null
    or quantity is null
    or price_per_unit is null
    or cogs is null;

--Data Exploration

--How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

--How many customer we have?
SELECT COUNT(DISTINCT customer_id) as total_customer
from retail_sales;

--how many categories we have?
SELECT COUNT(DISTINCT category) as total_category from retail_sales;

select DISTINCT category FROM retail_sales;

---Data Analysis & Business key problems & Answers

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

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM retail_sales
where
    category = 'Clothing'
    AND quantity > 3
    and sale_date BETWEEN '2022-11-01' and '2022-11-30';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT
    category,
    sum(total_sale) as net_sales,
    COUNT(*) as total_sale
FROM retail_sales
GROUP BY
    category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age), 2) as Averrage_age
FROM retail_sales
WHERE
    category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select
    gender,
    category,
    COUNT(*) as number_of_transactions
FROM retail_sales
GROUP BY
    1,
    2
ORDER BY 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT *
FROM (
        SELECT EXTRACT(
                YEAR
                FROM sale_date
            ) as year, EXTRACT(
                MONTH
                FROM sale_date
            ) as month, ROUND(AVG(total_sale), 2) as Avg_sale, RANK() over (
                PARTITION BY
                    EXTRACT(
                        YEAR
                        FROM sale_date
                    )
                ORDER BY ROUND(AVG(total_sale), 2) DESC
            ) as ranks
        FROM retail_sales
        GROUP BY
            1, 2
    ) t1
where
    ranks = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.
SELECT customer_id, sum(total_sale) as total_sales
FROM retail_sales
GROUP BY
    customer_id
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category, COUNT(DISTINCT customer_id) as unique_cst
FROM retail_sales
GROUP BY
    category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH
    Hourly_sales as (
        SELECT
            *,
            case
                WHEN EXTRACT(
                    HOUR
                    FROM sale_time
                ) <= 12 then "Morning"
                WHEN EXTRACT(
                    HOUR
                    FROM sale_time
                ) BETWEEN 12 and 17  THEN 'Afternoon'
                else "Evening"
            end as Shift
        from retail_sales
    )
select Shift, COUNT(*) as Total_orders
FROM Hourly_sales
GROUP BY
    Shift
ORDER BY 2 DESC;

--End of Projet