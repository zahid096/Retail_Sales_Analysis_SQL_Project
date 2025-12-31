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

SELECT * FROM retail_sales limit 10;

SELECT COUNT(*) FROM retail_sales;