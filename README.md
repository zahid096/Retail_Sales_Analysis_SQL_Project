# Retail Sales Analysis SQL Project

## Project Overview

**Project Tiltle**: Retail Sales Analysis  
**Database**: `retail_sales_analysis_sql_project`  

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data.The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Retail_Sales_Analysis_SQL_Project;`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE Retail_Sales_Analysis_SQL_Project;

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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
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

--How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

--How many customer we have?
SELECT COUNT(DISTINCT customer_id) as total_customer
from retail_sales;

--how many categories we have?
SELECT COUNT(DISTINCT category) as total_category from retail_sales;

select DISTINCT category FROM retail_sales;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**:
```sql
SELECT *
FROM retail_sales
where
    category = 'Clothing'
    AND quantity > 3
    and sale_date BETWEEN '2022-11-01' and '2022-11-30';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT
    category,
    sum(total_sale) as net_sales,
    COUNT(*) as total_sale
FROM retail_sales
GROUP BY
    category;
```
4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT ROUND(AVG(age), 2) as Averrage_age
FROM retail_sales
WHERE
    category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select
    gender,
    category,
    COUNT(*) as number_of_transactions
FROM retail_sales
GROUP BY
    1,
    2
ORDER BY 1;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT customer_id, sum(total_sale) as total_sales
FROM retail_sales
GROUP BY
    customer_id
ORDER BY 2 DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT category, COUNT(DISTINCT customer_id) as unique_cst
FROM retail_sales
GROUP BY
    category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## 👨‍💻 Author

**Md. Zahid Hasan**  
📧 [mdzahidhasan096@gmail.com](mailto:mdzahidhasan096@gmail.com)  
📍 Data Analyst | Excel Enthusiast | Research-driven Learner 