/*
==========================================
File : 07_Exploratory_Data_Analysis.sql
Project : E-Commerce Database Project
Author : Vinoth D
Database : ecommerce_project_01_db
Description : Exploratory Data Analysis (EDA).
==========================================
*/

-- ==========================================================================================================================
-- Section 1: Database Overview
-- ==========================================================================================================================

-- Q1. Find the total number of users.

SELECT count(*) 
AS Total_Users 
FROM users;

-- Q2. Find the total number of orders.

SELECT COUNT(*) 
AS Total_Orders 
FROM orders;

-- Q3. Find the total number of order items.

SELECT count(*) 
AS Total_Order_items
FROM order_items;

-- Q4. Find the total number of products.

SELECT count(*) 
AS Total_Products
FROM products;

-- Q5. Find the total number of inventory items.

SELECT count(*) 
AS Total_Inventory_Items
FROM inventory_items;

-- Q6. Find the total number of distribution centers.

SELECT count(*) 
AS Total_Distribution_Centers
FROM distribution_centers;

-- ==========================================================================================================================
-- Section 2: Users Exploration
-- ==========================================================================================================================

-- Q7. Find the number of users by gender.

SELECT 
	gender, 
    count(*) AS Total_Users_by_Gender
FROM users
GROUP BY gender
ORDER BY Total_Users_by_Gender DESC;

-- Q8. Find the number of users in each country.

SELECT 
	country, 
    count(*) AS Total_Users_by_Country
FROM users
GROUP BY country
ORDER BY Total_Users_by_Country DESC;

-- Q9. Find the number of users in each state.

SELECT 
	state, 
    count(*) AS Total_Users_in_Each_State
FROM users
GROUP BY state
ORDER BY Total_Users_in_Each_State DESC;

-- Q10. Find the top 10 cities with the highest number of users.

SELECT 
	city, 
    count(*) AS Top_10_Cities_with_Most_Users
FROM users
GROUP BY city
ORDER BY Top_10_Cities_with_Most_Users DESC
LIMIT 10;

-- Q11. Find the number of users by traffic source.

SELECT 
	traffic_source, 
    count(*) AS Total_Users_by_Traffic_Source
FROM users
GROUP BY traffic_source
ORDER BY Total_Users_by_Traffic_Source DESC;

-- Q12. Find the earliest and latest user registration dates.

SELECT
	MIN(created_at) AS Earliest_Registration_Date,
	MAX(created_at) AS Latest_Registration_Date
FROM users;

-- ==========================================================================================================================
-- Section 3: Orders Exploration
-- ==========================================================================================================================

-- Q13. Find the number of orders for each order status.

SELECT 
	status, 
    count(*) AS Total_Orders_by_Status
FROM orders
GROUP BY status
ORDER BY Total_Orders_by_Status DESC;

-- Q14. Find the number of orders by gender.

SELECT 
	gender, 
    count(*) AS Total_Orders_by_Gender
FROM orders
GROUP BY gender
ORDER BY Total_Orders_by_Gender DESC;

-- Q15. Find the minimum and maximum number of items per order.

SELECT 
	MIN(num_of_item) AS Minimum_Item,
	MAX(num_of_item) AS Maximum_Item
FROM orders;

-- Q16. Find the average number of items per order.

SELECT 
ROUND(AVG(num_of_item),2)
AS Average_Items_per_Order
FROM orders;

-- Q17. Find the earliest and latest order creation dates.

SELECT
	MIN(created_at) AS Earliest_Order_Creation_Date,
	MAX(created_at) AS Latest_Order_Creation_Date
FROM orders;

-- ==========================================================================================================================
-- Section 4: Products Exploration
-- ==========================================================================================================================

-- Q18. Find the number of products in each category.

SELECT 
	category, 
    count(*) AS Total_Products_by_Category
FROM products
GROUP BY category
ORDER BY Total_Products_by_Category DESC;

-- Q19. Find the number of products in each department.

SELECT 
	department, 
    count(*) AS Total_Products_by_Department
FROM products
GROUP BY department
ORDER BY Total_Products_by_Department DESC;

-- Q20. Find the number of products for each brand.

SELECT 
	brand, 
    count(*) AS Total_Products_by_Brand
FROM products
GROUP BY brand
ORDER BY Total_Products_by_Brand DESC;

-- Q21. Find the minimum, maximum, and average retail price.

SELECT 
	MIN(retail_price) AS Minimum_Retail_Price,
	MAX(retail_price) AS Maximum_Retail_Price,
    ROUND(AVG(retail_price),2) AS Average_Retail_Price
FROM products;

-- Q22. Find the minimum, maximum, and average product cost.

SELECT 
	MIN(cost) AS Minimum_Cost,
	MAX(cost) AS Maximum_Cost,
    ROUND(AVG(cost),2) AS Average_Cost
FROM products;

-- ==========================================================================================================================
-- Section 5: Inventory Exploration
-- ==========================================================================================================================

-- Q23. Find the total inventory items by product category.

SELECT 
	product_category, 
    count(*) AS Total_Inventory_by_Category
FROM inventory_items
GROUP BY product_category
ORDER BY Total_Inventory_by_Category DESC;

-- Q24. Find the total inventory items by product department.

SELECT 
	product_department, 
    count(*) AS Total_Inventory_by_Department
FROM inventory_items
GROUP BY product_department
ORDER BY Total_Inventory_by_Department DESC;

-- Q25. Find the earliest and latest inventory creation dates.

SELECT
	MIN(created_at) AS Earliest_Inventory_Creation_Date,
	MAX(created_at) AS Latest_Inventory_Creation_Date
FROM inventory_items;

-- Q26. Find the earliest and latest sold dates.

SELECT
	MIN(sold_at) AS Earliest_Sold_Date,
	MAX(sold_at) AS Latest_Sold_Date
FROM inventory_items;

-- ==========================================================================================================================
-- Section 6: Distribution Centers
-- ==========================================================================================================================

-- Q27. List all distribution centers.

SELECT 
	name AS Distribution_Centers
FROM distribution_centers
ORDER BY name ASC;

-- Q28. Find the number of products supplied by each distribution center.

SELECT 
	dc.name, 
    COUNT(p.id) AS Total_Products
FROM distribution_centers dc
LEFT JOIN products p
ON p.distribution_center_id=dc.id
GROUP BY dc.name
ORDER BY Total_Products DESC;

-- Q29. Find the number of inventory items stored in each distribution center.

SELECT 
	dc.name, 
    COUNT(ii.id) AS Total_Inventory_Items
FROM distribution_centers dc
LEFT JOIN inventory_items ii
ON ii.product_distribution_center_id=dc.id
GROUP BY dc.name
ORDER BY Total_Inventory_Items DESC;

-- ==========================================================================================================================
-- Section 7: General Exploration
-- ==========================================================================================================================

-- Q30. Find the distinct order statuses.

SELECT DISTINCT 
	status 
FROM orders;

-- Q31. Find the distinct product categories.

SELECT DISTINCT 
	category 
FROM products;

-- Q32. Find the distinct product departments.

SELECT DISTINCT 
	department 
FROM products;

-- Q33. Find the distinct traffic sources.

SELECT DISTINCT 
	traffic_source 
FROM users;

-- Q34. Find the distinct countries.

SELECT DISTINCT 
	country 
FROM users;

-- Q35. Find the distinct genders available in both users and orders.

SELECT DISTINCT 
	gender
FROM users
UNION
SELECT DISTINCT 
	gender
FROM orders;

-- ==========================================================================================================================
-- Section 8: Challenge Questions
-- ==========================================================================================================================

-- Q36. Which 10 brands have the highest number of products?

SELECT 
	brand,
    COUNT(id) AS Total_Products
FROM products
GROUP BY brand
ORDER BY Total_Products DESC
LIMIT 10;

-- Q37. Which 10 categories have the highest average retail price?

SELECT 
	category,
	ROUND(AVG(retail_price),2) AS Average_Retail_Price
FROM products
GROUP BY category
ORDER BY Average_Retail_Price DESC
LIMIT 10;

-- Q38. Which state has the highest number of users?

SELECT 
	state,
    COUNT(id) AS Highest_Number_of_Users_by_State
FROM users
GROUP BY state
ORDER BY Highest_Number_of_users_by_State DESC
LIMIT 1;

-- Q39. Which traffic source brings the most users?

SELECT 
	traffic_source,
    COUNT(id) AS Highest_Number_of_Users_by_Traffic_Source
FROM users
GROUP BY traffic_source
ORDER BY Highest_Number_of_Users_by_Traffic_Source DESC
LIMIT 1;

-- Q40. Which order status appears most frequently?

SELECT 
	status,
    COUNT(order_id) AS Total_Orders
FROM orders
GROUP BY status
ORDER BY Total_Orders DESC
LIMIT 1;
