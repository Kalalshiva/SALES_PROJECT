USE sales;
SELECT *FROM ORDERS_DATA

-- created sales database

-- 1) List all distinct cities where orders have been shipped
SELECT DISTINCT city 
FROM orders_data;

-- 2) Calculate total selling price and profits for all orders
SELECT 
    `Order Id`,
    SUM(`Quantity` * `List Price`) AS `Total Selling Price`,
    CAST(SUM((`List Price` - `cost price`) * `Quantity`) AS DECIMAL(10,2)) AS `Total Profit`
FROM orders_data
GROUP BY `Order Id`
ORDER BY `Total Profit` DESC;

-- 3) Find all orders from 'Technology' category shipped using 'Second Class'
SELECT `Order Id`, `Order Date`
FROM orders_data
WHERE `Category` = 'Technology' AND `Ship Mode` = 'Second Class'
ORDER BY `Order Date`;

-- 4) Find the average order value
SELECT CAST(AVG(`Quantity` * `List Price`) AS DECIMAL(10,2)) AS AOV
FROM orders_data;

-- 5) City with the highest total quantity
SELECT `City`, SUM(`Quantity`) AS `Total Quantity`
FROM orders_data
GROUP BY `City`
ORDER BY `Total Quantity` DESC
LIMIT 1;

-- 6) Rank orders in each region by quantity
SELECT 
    `Order Id`, 
    `Region`, 
    `Quantity` AS Total_Quantity,
    DENSE_RANK() OVER (PARTITION BY `Region` ORDER BY `Quantity` DESC) AS rnk
FROM orders_data
ORDER BY `Region`, rnk;

-- 7) Orders placed in the first quarter (Jan–Mar)
SELECT 
    `Order Id`, 
    SUM(`Quantity` * `List Price`) AS `Total Value`
FROM orders_data
WHERE MONTH(`Order Date`) IN (1,2,3)
GROUP BY `Order Id`
ORDER BY `Total Value` DESC;

-- 8) Top 10 highest profit generating products
SELECT 
    `Product Id`,
    SUM((`List Price` - `cost price`) * `Quantity`) AS profit
FROM orders_data
GROUP BY `Product Id`
ORDER BY profit DESC
LIMIT 10;

-- 9) Top 3 highest selling products in each region
SELECT *
FROM (
    SELECT 
        `Region`,
        `Product Id`,
        SUM(`Quantity` * `List Price`) AS sales,
        ROW_NUMBER() OVER (PARTITION BY `Region` ORDER BY SUM(`Quantity` * `List Price`) DESC) AS rn
    FROM orders_data
    GROUP BY `Region`, `Product Id`
) AS sub
WHERE rn <= 3;


-- 10) Month over month sales comparison for 2022 vs 2023
SELECT 
    order_month,
    ROUND(SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END), 2) AS sales_2022,
    ROUND(SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END), 2) AS sales_2023
FROM (
    SELECT 
        YEAR(`Order Date`) AS order_year,
        MONTH(`Order Date`) AS order_month,
        SUM(`Quantity` * `List Price`) AS sales
    FROM orders_data
    GROUP BY YEAR(`Order Date`), MONTH(`Order Date`)
) AS sub
GROUP BY order_month
ORDER BY order_month;

-- 11) For each category, month with highest sales
SELECT Category, `Order Year-Month`, `Total Sales`
FROM (
    SELECT 
        `Category`,
        DATE_FORMAT(`Order Date`, '%Y-%m') AS `Order Year-Month`,
        SUM(`Quantity` * `List Price`) AS `Total Sales`,
        ROW_NUMBER() OVER (PARTITION BY `Category` ORDER BY SUM(`Quantity` * `List Price`) DESC) AS rn
    FROM orders_data
    GROUP BY `Category`, DATE_FORMAT(`Order Date`, '%Y-%m')
) AS sub
WHERE rn = 1;




-- 12) Subcategory with highest growth 2023 vs 2022
SELECT 
    sub_category AS `Sub Category`,
    sales_2022 AS `Sales in 2022`,
    sales_2023 AS `Sales in 2023`,
    (sales_2023 - sales_2022) AS `Diff in Amount`
FROM (
    SELECT 
        `Sub Category` AS sub_category,
        ROUND(SUM(CASE WHEN YEAR(`Order Date`) = 2022 THEN (`Quantity` * `List Price`) ELSE 0 END), 2) AS sales_2022,
        ROUND(SUM(CASE WHEN YEAR(`Order Date`) = 2023 THEN (`Quantity` * `List Price`) ELSE 0 END), 2) AS sales_2023
    FROM orders_data
    GROUP BY `Sub Category`
) AS sub
ORDER BY (sales_2023 - sales_2022) DESC
LIMIT 1;
