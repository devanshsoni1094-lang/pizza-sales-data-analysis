CREATE DATABASE pizza_db; # a database is created named pizza_db
use pizza_db;# database pizza_db is taken in use
SELECT * FROM pizza_sales limit 48597;# this is used to show the entire data 
SELECT SUM(total_price) AS total_revenue FROM pizza_sales; # helps to calculate and show the total revenue of from the table pizza_sales
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS average_order_value FROM pizza_sales; # helps to calculate and show average order value from the table pizza_sales
SELECT SUM(quantity) as total_pizza_sold FROM pizza_sales; # helps to calculate and show total number of pizza sold
SELECT COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales;# helps to find the total number of orders from table pizza_sales
SELECT SUM(quantity)/COUNT(DISTINCT order_id) AS average_pizza_per_order FROM pizza_sales; # helps to find the avg pizza per order

# Daily Trend:
SELECT DAYNAME(STR_TO_DATE(order_date, '%Y-%m-%d %H:%i:%s')) AS order_day,COUNT(DISTINCT order_id) AS Total_orders # Convert text to DATETIME, extract weekday name, rename as order_day & Count unique orders for each day and rename as Total_orders
FROM pizza_sales # Select data from pizza_sales table
WHERE order_date IS NOT NULL #  Exclude rows where order_date is NULL
GROUP BY DAYNAME(STR_TO_DATE(order_date, '%Y-%m-%d %H:%i:%s')) # Group records by weekday so counting happens per day
ORDER BY Total_orders DESC; #Sort results from highest orders to lowest

# Hourly Trend:
SELECT HOUR(order_time) AS order_hours,COUNT(DISTINCT order_id) AS Total_orders # Extract hour (0–23) from order_time and rename it as order_hours ,Count unique orders placed in each hour
FROM pizza_sales # Source table containing order data
WHERE HOUR(order_time) BETWEEN 9 AND 23 # Filter data to include only orders between 9 AM and 11 PM
GROUP BY HOUR(order_time) # Group records by each hour so counting happens per hour
ORDER BY order_hours; # Sort results in ascending order (9 → 23)

SELECT pizza_category,SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS percentage  # Select pizza category (Veg, Non-Veg, etc.) , Calculate category revenue percentage:(category total revenue / overall total revenue) × 100
FROM pizza_sales # Source table containing all pizza sales records
GROUP BY pizza_category; #  Group data by pizza category so revenue is calculated per category

SELECT pizza_size,SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS percentage  # Select pizza category (Veg, Non-Veg, etc.) , Calculate category revenue percentage:(category total revenue / overall total revenue) × 100
FROM pizza_sales # Source table containing all pizza sales records
GROUP BY pizza_size; #  Group data by pizza category so revenue is calculated per category

SELECT pizza_size,SUM(total_price)*100.0 /(SELECT SUM(total_price) FROM pizza_sales 
 WHERE QUARTER(STR_TO_DATE(order_date,'%d-%m-%Y'))=1) AS percentage
FROM pizza_sales
WHERE QUARTER(STR_TO_DATE(order_date,'%d-%m-%Y'))=1
GROUP BY pizza_size;

SELECT pizza_category,sum(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_category

SELECT pizza_name, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold DESC
LIMIT 5;

SELECT pizza_name, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold ASC
LIMIT 5;






