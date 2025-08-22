**SQL – Orders_data Analysis**
This project contains a set of 12 SQL business questions solved using an sales orders_dataset.
The goal is to practice and demonstrate SQL skills such as data aggregation, filtering, ranking, and time-based analysis.

**Project Purpose**
To explore real-world business questions using SQL.
To practice writing queries for analytics and reporting.
To understand how to derive actionable insights from raw sales data.
To work with concepts like grouping, window functions, date functions, and growth analysis.

**Dataset Information**

The dataset is stored in a MySQL table named orders_data with the following columns:

Order Id,Order Date,Ship Mode,Segment,Country,City,State,Postal Code,Region,Category,Sub Category,Product Id,Cost Price,List Price,Quantity,Discount Percent

**Business Questions Solved**

1.List all distinct cities where orders have been shipped.
2.Calculate the total selling price and profits for all orders.
3.Find all orders from the 'Technology' category that were shipped using 'Second Class', ordered by order date.
4.Find the average order value (AOV).
5.Find the city with the highest total quantity of products ordered.
6.Use a window function to rank orders in each region by quantity in descending order.
7.List all orders placed in the first quarter of any year (January to March), including the total cost for these orders.
8.Find the top 10 highest profit-generating products.
9.Find the top 3 highest selling products in each region.
10.Find the month-over-month sales comparison for 2022 and 2023 (e.g., Jan 2022 vs Jan 2023).
11.For each category, find the month with the highest sales.
12.Find the sub-category with the highest sales growth in 2023 compared to 2022.

**Key SQL Concepts Practiced**

➡️Aggregation Functions (SUM, AVG)
➡️Filtering (WHERE, DISTINCT)
➡️Sorting & Ranking (ORDER BY, LIMIT, ROW_NUMBER)
➡️Grouping (GROUP BY)
➡️Window Functions (for ranking and comparisons)
➡️Date Functions (MONTH, YEAR, DATE_FORMAT)
➡️Growth Analysis (year-over-year comparisons)
