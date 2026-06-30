/*
==========================================
File : 08_Business_Analysis.sql
Project : E-Commerce Database Project
Author : Vinoth D
Database : ecommerce_project_01_db
Description : Business Analysis.
==========================================
*/

-- ==========================================================================================================================
-- Level 1 : Business KPIs
-- ==========================================================================================================================

-- Q1. What is the total revenue generated?

SELECT SUM(sale_price) AS Total_Revenue
FROM order_items;

-- Q2. How many unique customers have placed orders?

SELECT 
	COUNT(DISTINCT user_id) AS Total_Unique_Customers
FROM orders;

-- Q3. How many total orders were placed?

SELECT 
	COUNT(*) AS Order_Totals
FROM orders;

-- Q4. How many total products were sold?

SELECT COUNT(*) AS Total_Sold_Products
FROM order_items;

-- Q5. What is the average order value (AOV)?

SELECT ROUND(AVG(Order_Value),2) AS Average_Order_Value
FROM
	(
	SELECT 
		order_id,
		SUM(sale_price) AS Order_Value
	FROM order_items
	GROUP BY order_id
    )
    AS Order_Totals;

-- Q6. What is the average selling price of products?

SELECT 
	ROUND(AVG(sale_price), 2) AS Average_Selling_Price
FROM order_items;

-- Q7. What is the highest-priced product?

SELECT 
	name,
	retail_price
FROM products
WHERE retail_price = 
(
SELECT MAX(retail_price)
FROM products
);


-- Q8. What is the lowest-priced product?

SELECT 
	name,
	retail_price
FROM products
WHERE retail_price = 
(
SELECT MIN(retail_price)
FROM products
);

-- Q9. What is the total number of cancelled orders?

SELECT 
	COUNT(*) AS Cancelled_Orders
FROM orders
WHERE status = 'Cancelled';

-- Q10. What is the total number of returned orders?

SELECT 
	COUNT(*) AS Returned_Orders
FROM orders
WHERE status = 'Returned';

-- ==========================================================================================================================
-- Level 2: Customer Analysis
-- ==========================================================================================================================

-- Q1. Which customers placed the most orders?

WITH customer_orders AS
(
    SELECT
		u.id,
        u.first_name,
        u.last_name,
        COUNT(o.order_id) AS Total_Orders
    FROM users u
    INNER JOIN orders o
        ON u.id = o.user_id
    GROUP BY 
		u.id, 
        u.first_name, 
        u.last_name
)
SELECT
	id,
    first_name,
    last_name,
    Total_Orders
FROM customer_orders
WHERE Total_Orders =
(
    SELECT MAX(Total_Orders)
    FROM customer_orders
);

-- Q2. Which customers generated the highest revenue?

WITH User_Revenue AS
(
SELECT
	u.id, 
	u.first_name,
	u.last_name,
	SUM(oi.sale_price) AS Revenue
FROM users u
INNER JOIN order_items oi
ON u.id = oi.user_id
GROUP BY 
	u.id, 
	u.first_name, 
	u.last_name
)
SELECT
	id,
	first_name,
	last_name,
    Revenue
FROM User_Revenue
WHERE Revenue = 
( 
SELECT MAX(Revenue)
FROM User_Revenue
);

-- Q3. Which states have the highest revenue?

WITH State_Revenue AS
(
	SELECT
		state,
		SUM(oi.sale_price) AS Revenue
	FROM users u
	INNER JOIN order_items oi
	ON u.id = oi.user_id
	GROUP BY 
		state
)
SELECT
	state,
    Revenue
FROM State_Revenue
WHERE Revenue =
(
	SELECT MAX(Revenue)
    FROM State_Revenue
);

-- Q4. Which cities have the most active customers?

WITH Total_City_Customers AS
(
SELECT
	city,
    COUNT(DISTINCT o.user_id) AS Total_Customers
FROM users u
INNER JOIN orders o
ON u.id=o.user_id
GROUP BY city
)
SELECT
	city,
    Total_Customers
FROM Total_City_Customers
WHERE Total_Customers =
(
SELECT 
	MAX(Total_Customers)
    FROM Total_City_Customers
);

-- Q5. What is the average spending per customer?

SELECT
	ROUND(AVG(Customer_Spending),2) AS Average_Customer_Spending
    FROM
    (
SELECT 
	u.id,
	SUM(oi.sale_price) AS Customer_Spending
FROM users u
INNER JOIN order_items oi
ON u.id=oi.user_id
GROUP BY u.id
) AS Customer_Spending;

-- Q6. Which customer bought the most products?

WITH customer_Products AS
(
    SELECT
		u.id,
        u.first_name,
        u.last_name,
        COUNT(oi.product_id) AS Total_Products
    FROM users u
    LEFT JOIN order_items oi
        ON u.id = oi.user_id
    GROUP BY 
		u.id, 
        u.first_name, 
        u.last_name
)
SELECT
	id,
    first_name,
    last_name,
    Total_Products
FROM customer_Products
WHERE Total_Products =
(
    SELECT MAX(Total_Products)
    FROM customer_Products
);

-- Q7. Which traffic source generates the highest revenue?

WITH Highest_Revenue AS
(
SELECT 
	u.traffic_source,
    SUM(oi.sale_price) AS Traffic_Revenue
FROM users u
INNER JOIN order_items oi
ON u.id=oi.user_id
GROUP BY u.traffic_source
)
SELECT
	traffic_source,
    Traffic_Revenue
FROM Highest_Revenue
WHERE Traffic_Revenue =
(
	SELECT MAX(Traffic_Revenue)
    FROM Highest_Revenue
);

-- Q8. Which gender contributes the most revenue?

WITH Gender_Revenue AS
(
SELECT 
	u.gender,
    SUM(oi.sale_price) AS Gender_summary
FROM users u
INNER JOIN order_items oi
ON u.id=oi.user_id
GROUP BY u.gender
)
SELECT
	gender,
    Gender_summary
FROM Gender_Revenue
WHERE Gender_summary =
(
	SELECT MAX(Gender_summary)
    FROM Gender_Revenue
);

-- Q9. Which country has the highest average order value?

WITH Order_Totals AS
(
SELECT 
	order_id,
	SUM(sale_price) AS Order_Value
FROM order_items
GROUP BY order_id
),
Country_AOV AS
(
SELECT 
	u.country,
    ROUND(AVG(Order_Value),2) AS Average_Order_Value
FROM Order_Totals
INNER JOIN orders o
ON Order_Totals.order_id=o.order_id
INNER JOIN users u
ON u.id=o.user_id
GROUP BY u.country
)
SELECT
    country,
    Average_Order_Value
FROM Country_AOV
WHERE Average_Order_Value =
(
SELECT MAX(Average_Order_Value)
FROM Country_AOV
);

-- Q10. Top 10 customers by revenue.

SELECT
	u.id,
	u.first_name,
    u.last_name,
    SUM(oi.sale_price) AS Customer_Revenue
FROM users u
INNER JOIN order_items oi
ON u.id=oi.user_id
GROUP BY 
	u.id,
	u.first_name,
    u.last_name
ORDER BY Customer_Revenue DESC
LIMIT 10;

-- ==========================================================================================================================
-- Level 3: Product Analysis
-- ==========================================================================================================================

-- Q1. Which product generated the highest revenue?

WITH Product_Revenue AS
(
	SELECT 
		oi.product_id,
		p.name,
		SUM(oi.sale_price) AS Product_Revenue
	FROM order_items oi
	INNER JOIN products p
	ON p.id=oi.product_id
	GROUP BY
		oi.product_id,
		p.name
	ORDER BY Product_Revenue DESC
)
SELECT
	product_id,
    name,
    Product_Revenue
FROM Product_Revenue
WHERE Product_Revenue =
(
	SELECT MAX(Product_Revenue)
    FROM Product_Revenue
);

-- Q2. Which product was sold the most?

WITH Total_Sold_Products AS
(
	SELECT 
		oi.product_id,
		p.name,
		COUNT(oi.order_id) AS Total_Sold
	FROM order_items oi
	INNER JOIN products p
	ON p.id=oi.product_id
	GROUP BY
		oi.product_id,
		p.name
        ORDER BY Total_Sold DESC
)
SELECT
	product_id,
    name,
    Total_Sold
FROM Total_Sold_Products
WHERE Total_Sold =
(
	SELECT MAX(Total_Sold)
    FROM Total_Sold_Products
);

-- Q3. Which categories generated the highest revenue?

WITH Category_Revenue AS
(
	SELECT 
		p.category,
		SUM(oi.sale_price) AS Revenue
	FROM order_items oi
	INNER JOIN products p
	ON p.id=oi.product_id
	GROUP BY
		p.category
)
SELECT
    category,
    Revenue
FROM Category_Revenue
WHERE Revenue =
(
	SELECT MAX(Revenue)
    FROM Category_Revenue
);

-- Q4. Which department generated the highest revenue?

WITH Department_Revenue AS
(
	SELECT 
		p.department,
		SUM(oi.sale_price) AS Revenue
	FROM order_items oi
	INNER JOIN products p
	ON p.id=oi.product_id
	GROUP BY
		p.department
) 
SELECT
    department,
    Revenue
FROM Department_Revenue
WHERE Revenue =
(
	SELECT MAX(Revenue)
    FROM Department_Revenue
);

-- Q5. Which brand generated the highest revenue?

WITH Brand_Revenue AS
(
	SELECT 
		p.brand,
		SUM(oi.sale_price) AS Revenue
	FROM order_items oi
	INNER JOIN products p
	ON p.id=oi.product_id
	GROUP BY
		p.brand
)
SELECT
    brand,
    Revenue
FROM Brand_Revenue
WHERE Revenue =
(
	SELECT MAX(Revenue)
    FROM Brand_Revenue
);

-- Q6. What is the average selling price by category?

SELECT 
	p.category,
	ROUND(AVG(oi.sale_price),2) AS Average_Category_Selling_Price
FROM order_items oi
INNER JOIN products p
ON p.id=oi.product_id
GROUP BY
	p.category;

-- Q7. Which products have never been sold?

SELECT
	p.id,
    p.name,
    oi.product_id
FROM products p
LEFT JOIN order_items oi
ON p.id=oi.product_id
WHERE oi.product_id IS NULL;

-- Q8. Which category has the most products?

WITH Total_Products AS
(
SELECT
	category,
    COUNT(id) AS Total_Items
FROM products
GROUP BY category
)
SELECT
	category,
    Total_Items
FROM Total_Products
WHERE Total_Items =
(
	SELECT MAX(Total_Items)
    FROM Total_Products
);

-- Q9. Which brand has the most products sold?

WITH Total_Products AS
(
SELECT
	brand,
    COUNT(product_id) AS Total_Items
FROM order_items oi
INNER JOIN products p
ON oi.product_id=p.id
GROUP BY brand
)
SELECT
	brand,
    Total_Items
FROM Total_Products
WHERE Total_Items =
(
	SELECT MAX(Total_Items)
    FROM Total_Products
);

-- Q10. Top 10 products by revenue.

SELECT
	oi.product_id,
    p.name,
    SUM(oi.sale_price) AS Product_Revenue
FROM order_items oi
INNER JOIN products p
ON oi.product_id=p.id
GROUP BY 
	oi.product_id,
    p.name
ORDER BY Product_Revenue DESC
LIMIT 10;

-- ==========================================================================================================================
-- Level 4: Sales & Time Analysis
-- ==========================================================================================================================

-- Q1. What is the total revenue generated each year?

SELECT
	YEAR(created_at) AS Order_Year,
    SUM(sale_price) AS Revenue
FROM order_items
GROUP BY Order_Year;

-- Q2. What is the total revenue generated each month?

SELECT
	MONTHNAME(created_at) AS Order_Month,
    SUM(sale_price) AS Revenue
FROM order_items
GROUP BY 
	MONTH(created_at),
    Order_Month
ORDER BY
	MONTH(created_at);

-- Q3. Which year generated the highest revenue?

WITH Yearly_Revenue AS
(
SELECT
	YEAR(created_at) AS Order_Year,
    SUM(sale_price) AS Revenue
FROM order_items
GROUP BY Order_Year
)
SELECT
	Order_Year,
	Revenue
FROM Yearly_Revenue
WHERE Revenue=
(
	SELECT MAX(Revenue)
    FROM Yearly_Revenue
);

-- Q4. Which month generated the highest revenue?

WITH Monthly_Revenue AS
(
SELECT
	MONTHNAME(created_at) AS Order_Month,
    SUM(sale_price) AS Revenue
FROM order_items
GROUP BY Order_Month
)
SELECT
	Order_Month,
	Revenue
FROM Monthly_Revenue
WHERE Revenue=
(
	SELECT MAX(Revenue)
    FROM Monthly_Revenue
);

-- Q5. What is the average monthly revenue?

WITH Monthly_Revenue AS
(
SELECT
	MONTHNAME(created_at) AS Order_Month,
    SUM(sale_price) AS Revenue
FROM order_items
GROUP BY 
	MONTHNAME(created_at),
    MONTH(created_at)
)
SELECT
   ROUND(AVG(Revenue),2) AS Average_Monthly_Revenue
FROM Monthly_Revenue;

-- Q6. Which day of the week generates the highest revenue?

WITH Day_Revenue AS
(
SELECT
	DAYNAME(created_at) AS Order_Day,
    SUM(sale_price) AS Revenue
FROM order_items
GROUP BY 
	DAYNAME(created_at)
)
SELECT
	Order_Day,
	Revenue
FROM Day_Revenue
WHERE Revenue=
(
	SELECT MAX(Revenue)
    FROM Day_Revenue
);

-- Q7. Which quarter generates the highest revenue?

WITH Quarter_Year AS
(
SELECT
	QUARTER(created_at) AS Year_Quarter,
    SUM(sale_price) AS Revenue
FROM order_items
GROUP BY 
	Year_Quarter
)
SELECT
	Year_Quarter,
	Revenue
FROM Quarter_Year
WHERE Revenue=
(
	SELECT MAX(Revenue)
    FROM Quarter_Year
);

-- Q8. Which year has the highest number of orders?

WITH Yearly_Orders AS
(
SELECT
	YEAR(created_at) AS Order_Year,
    COUNT(order_id) AS Total_Orders
FROM order_items
GROUP BY Order_Year
)
SELECT
	Order_Year,
	Total_Orders
FROM Yearly_Orders
WHERE Total_Orders=
(
	SELECT MAX(Total_Orders)
    FROM Yearly_Orders
);

-- Q9. Which month has the highest number of orders?

WITH Monthly_Orders AS
(
SELECT
	MONTHNAME(created_at) AS Order_Month,
    COUNT(order_id) AS Total_Orders
FROM order_items
GROUP BY
	MONTHNAME(created_at)
)
SELECT
	Order_Month,
	Total_Orders
FROM Monthly_Orders
WHERE Total_Orders=
(
	SELECT MAX(Total_Orders)
    FROM Monthly_Orders
);

-- Q10. Which date had the highest revenue?

WITH Daily_Revenue AS
(
SELECT
	DATE(created_at) AS Order_Date,
	SUM(sale_price) AS Revenue
FROM order_items
GROUP BY
	DATE(created_at)
)
SELECT
	Order_Date,
	Revenue
FROM Daily_Revenue
WHERE Revenue=
(
	SELECT MAX(Revenue)
    FROM Daily_Revenue
);

-- ==========================================================================================================================
-- Level 5: Order Analysis
-- ==========================================================================================================================

-- Q1. Which orders contain the most items?

SELECT
	order_id,
    num_of_item
FROM orders
WHERE num_of_item =
(
	SELECT MAX(num_of_item)
    FROM orders
);

-- Q2. What is the average number of items per order?

SELECT
	ROUND(AVG(num_of_item),2) AS Average_Order_Items
FROM orders;

-- Q3. Which order status is the most common?

WITH Total_Orders AS
(
SELECT
	status,
	COUNT(*) AS Orders
FROM orders
GROUP BY status
)
SELECT
	status,
    Orders
FROM Total_Orders
WHERE Orders =
(
	SELECT MAX(Orders)
    FROM Total_Orders
);

-- Q4. What percentage of orders were cancelled?

SELECT
	ROUND(((Cancelled_Orders)/(Total_Orders)*100),2)
	AS Cancelled_Order_Percentage
FROM
(
SELECT 
    COUNT(*) AS Cancelled_Orders
FROM orders
WHERE status = 'Cancelled'
) AS Cancelled_Orders,
(
SELECT 
    COUNT(*) AS Total_Orders
FROM orders
) AS Total_Orders;

-- Q5. What percentage of orders were returned?

SELECT
	ROUND(((Returned_Orders)/(Total_Orders)*100),2)
	AS Returned_Order_Percentage
FROM
(
SELECT 
    COUNT(*) AS Returned_Orders
FROM orders
WHERE status = 'Returned'
) AS Returned_Orders,
(
SELECT 
    COUNT(*) AS Total_Orders
FROM orders
) AS Total_Orders;

-- Q6. Which gender places the most orders?

WITH Total_Orders AS
(
SELECT
	gender,
	COUNT(*) AS Orders
FROM orders
GROUP BY gender
)
SELECT
	gender,
    Orders
FROM Total_Orders
WHERE Orders =
(
	SELECT MAX(Orders)
    FROM Total_Orders
);

-- Q7. Which traffic source generates the most orders?

WITH Total_Orders AS
(
SELECT
	traffic_source,
	COUNT(o.order_id) AS Orders
FROM orders o
INNER JOIN users u
ON u.id=o.user_id
GROUP BY traffic_source
)
SELECT
	traffic_source,
    Orders
FROM Total_Orders
WHERE Orders =
(
	SELECT MAX(Orders)
    FROM Total_Orders
);

-- Q8. What is the average delivery time?

SELECT
	ROUND(AVG(DATEDIFF(delivered_at, created_at)),2) 
    AS Average_Delivery_Time
FROM orders
WHERE delivered_at IS NOT NULL;

-- Q9. What is the average shipping time?

SELECT
	ROUND(AVG(DATEDIFF(shipped_at, created_at)),2) 
    AS Average_Shipping_Time
FROM orders
WHERE shipped_at IS NOT NULL;

-- Q10. Which country places the most orders?

WITH Total_Orders AS
(
SELECT
	country,
	COUNT(o.order_id) AS Orders
FROM orders o
INNER JOIN users u
ON u.id=o.user_id
GROUP BY country
)
SELECT
	country,
    Orders
FROM Total_Orders
WHERE Orders =
(
	SELECT MAX(Orders)
    FROM Total_Orders
);

-- ==========================================================================================================================
-- Level 6: Inventory Analysis
-- ==========================================================================================================================

-- Q1. How many inventory items are currently unsold?

SELECT 
	COUNT(*) AS Unsold_Items
FROM inventory_items
WHERE sold_at IS NULL;

-- Q2. Which distribution center stores the highest number of inventory items?

WITH Total_Inventory_Items AS
(
SELECT
	dc.id,
	dc.name,
    COUNT(*) Total_Items
FROM inventory_items ii
LEFT JOIN distribution_centers dc
ON ii.product_distribution_center_id=dc.id
GROUP BY 
	dc.id,
	dc.name
)
SELECT
	id,
	name,
    Total_Items
FROM Total_Inventory_Items
WHERE Total_Items =
(
	SELECT MAX(Total_Items)
    FROM Total_Inventory_Items
);

-- Q3. Which product category has the largest inventory?

WITH Total_Items AS
(
SELECT
	product_category,
    COUNT(product_id) AS Items
FROM inventory_items
GROUP BY product_category
)
SELECT
	product_category,
    Items
FROM Total_Items
WHERE Items =
(
	SELECT MAX(Items)
    FROM Total_Items
);

-- Q4. Which brand has the highest unsold inventory?

WITH Unsold_Brand_Items AS
(
SELECT 
	product_brand,
	COUNT(*) AS Unsold_Items
FROM inventory_items
WHERE sold_at IS NULL
GROUP BY product_brand
)
SELECT 
	product_brand,
	Unsold_Items
FROM Unsold_Brand_Items
WHERE Unsold_Items =
(
	SELECT MAX(Unsold_Items)
    FROM Unsold_Brand_Items
);

-- Q5. Which distribution center has the highest unsold inventory?

WITH Unsold_Inventory_Items AS
(
SELECT 
	dc.id,
	dc.name,
    COUNT(*) AS Unsold_Items
FROM inventory_items ii
LEFT JOIN distribution_centers dc
ON ii.product_distribution_center_id=dc.id
WHERE sold_at IS NULL
GROUP BY 
	dc.id,
	dc.name
)
SELECT 
	id,
	name,
    Unsold_Items
FROM Unsold_Inventory_Items
WHERE Unsold_Items =
(
	SELECT MAX(Unsold_Items)
    FROM Unsold_Inventory_Items
);

-- Q6. What percentage of inventory has been sold?

SELECT
	ROUND(((Sold_Items)/(Total_Items)*100),2) 
    AS Sold_Percentage
FROM
(
SELECT
	COUNT(*) AS Total_Items
FROM inventory_items
) AS Total_Items,
(
SELECT
	COUNT(*) AS Sold_Items
FROM inventory_items
WHERE sold_at IS NOT NULL
) AS Sold_Items;

-- Q7. Which category has the highest inventory turnover?

WITH Category_Sales AS
( 
	SELECT 
		ii.product_category, 
        COUNT(oi.id) AS Items_Sold 
	FROM inventory_items ii 
    INNER JOIN order_items oi 
    ON ii.product_id=oi.product_id 
    GROUP BY ii.product_category 
)
SELECT 
	product_category, 
    Items_Sold 
FROM Category_Sales
WHERE Items_Sold = 
( 
	SELECT MAX(Items_Sold) 
    FROM Category_Sales
);

-- Q8. Which products have more inventory than the average inventory per product?

WITH Total_Inventory_Items AS
(
SELECT 
	product_name,
    COUNT(id) AS Total_Items
FROM inventory_items
GROUP BY product_name
)
SELECT 
	product_name,
    Total_Items
FROM Total_Inventory_Items
WHERE Total_Items >
(
	SELECT 
		AVG(Total_Items) AS Average_Items
	FROM Total_Inventory_Items
);

-- Q9. Which distribution center has the highest sell-through rate?

WITH Sold AS
(
    SELECT
        dc.id,
        dc.name,
        COUNT(*) AS Sold_Items
    FROM inventory_items ii
    INNER JOIN distribution_centers dc
        ON ii.product_distribution_center_id = dc.id
    WHERE ii.sold_at IS NOT NULL
    GROUP BY
        dc.id,
        dc.name
),
Total AS
(
    SELECT
        dc.id,
        dc.name,
        COUNT(*) AS Total_Items
    FROM inventory_items ii
    INNER JOIN distribution_centers dc
        ON ii.product_distribution_center_id = dc.id
    GROUP BY
        dc.id,
        dc.name
),
DC_Rate AS
(
    SELECT
        Sold.id,
        Sold.name,
        Sold.Sold_Items,
        Total.Total_Items,
        ROUND((Sold.Sold_Items / Total.Total_Items) * 100, 2)
            AS Sell_Through_Rate
    FROM Sold
    INNER JOIN Total
        ON Sold.id = Total.id
)
SELECT
    id,
    name,
    Sell_Through_Rate
FROM DC_Rate
WHERE Sell_Through_Rate =
(
    SELECT MAX(Sell_Through_Rate)
    FROM DC_Rate
);

-- Q10. Which brands have sold more than the average number of inventory items?

WITH Total_Inventory_Items AS
(
	SELECT 
		product_brand,
		COUNT(*) AS Total_Items
	FROM inventory_items
	WHERE sold_at IS NOT NULL
	GROUP BY product_brand
)
SELECT 
	product_brand,
    Total_Items
FROM Total_Inventory_Items
WHERE Total_Items >
(
SELECT AVG(Total_Items) AS Average_Items
FROM Total_Inventory_Items
);

-- ==========================================================================================================================
-- Level 7: Distribution Center Analysis
-- ==========================================================================================================================

-- Q1. Which distribution center generated the highest revenue?

WITH DC_Revenue AS
(
	SELECT 
		dc.id,
		dc.name,
		SUM(oi.sale_price) AS Revenue
	FROM order_items oi
	INNER JOIN inventory_items ii
	ON oi.inventory_item_id=ii.id
	LEFT JOIN distribution_centers dc
	ON ii.product_distribution_center_id=dc.id
	GROUP BY 
		dc.id,
		dc.name
)
SELECT
    name,
    Revenue
FROM DC_Revenue
WHERE Revenue =
(
	SELECT MAX(Revenue)
    FROM DC_Revenue
);

-- Q2. Which distribution center sold the highest number of inventory items?

WITH Sold_Inventory_Items AS
(
	SELECT 
		dc.name,
		COUNT(*) AS Sold_items
	FROM inventory_items ii
	LEFT JOIN distribution_centers dc
	ON ii.product_distribution_center_id=dc.id
	WHERE ii.sold_at IS NOT NULL
	GROUP BY dc.name
)
SELECT
	name,
	Sold_items
FROM Sold_Inventory_Items
WHERE Sold_items =
(
	SELECT MAX(Sold_items)
	FROM Sold_Inventory_Items
);

-- Q3. Which distribution center has the highest average selling price?

WITH DC_Average_Sale_Price AS
(
SELECT 
		dc.name,
		ROUND(AVG(oi.sale_price),2) AS Average_Sale_Price
FROM inventory_items ii
INNER JOIN order_items oi
ON ii.id=oi.inventory_item_id
LEFT JOIN distribution_centers dc
ON ii.product_distribution_center_id=dc.id
GROUP BY dc.name
)
SELECT
	name,
    Average_Sale_Price
FROM DC_Average_Sale_Price
WHERE Average_Sale_Price =
(
	SELECT MAX(Average_Sale_Price)
    FROM DC_Average_Sale_Price
);

-- Q4. Which distribution center has the largest inventory?

WITH Total_Inventory_Items AS 
(
SELECT
	dc.id,
    dc.name,
    COUNT(*) AS Total_Items
FROM inventory_items ii
LEFT JOIN distribution_centers dc
ON ii.product_distribution_center_id=dc.id
GROUP BY 
	dc.id,
    dc.name
)
SELECT
	name,
    Total_Items
FROM Total_Inventory_Items
WHERE Total_Items =
(
	SELECT MAX(Total_Items)
	FROM Total_Inventory_Items
);

-- Q5. Which distribution center has the highest percentage of sold inventory?

WITH Sold_Inventory AS
(
	SELECT
		dc.id,
		dc.name,
		COUNT(*) AS Sold_Items
	FROM inventory_items ii
	LEFT JOIN distribution_centers dc
	ON ii.product_distribution_center_id=dc.id
	WHERE sold_at IS NOT NULL
	GROUP BY 
		dc.id,
		dc.name
),
Total_Inventory AS 
(
	SELECT
		dc.id,
		dc.name,
		COUNT(*) AS Total_Items
	FROM inventory_items ii
	LEFT JOIN distribution_centers dc
	ON ii.product_distribution_center_id=dc.id
	GROUP BY 
		dc.id,
		dc.name
),
Sold_Inventory_Percentage AS
(
	SELECT
		Sold_Inventory.id,
		Sold_Inventory.name,
		ROUND((Sold_Inventory.Sold_Items / Total_Inventory.Total_Items) * 100, 2)
		AS Sold_Percentage
	FROM Sold_Inventory
    INNER JOIN Total_Inventory
	ON Sold_Inventory.id = Total_Inventory.id
)
SELECT
	name,
    Sold_Percentage
FROM Sold_Inventory_Percentage
WHERE Sold_Percentage =
(
	SELECT MAX(Sold_Percentage)
	FROM Sold_Inventory_Percentage
);

-- Q6. Which distribution center stores the highest number of product categories?

WITH DC_Category_Total AS
(
SELECT 
	dc.id,
    dc.name,
    COUNT(DISTINCT product_category) AS Category_Total
FROM inventory_items ii
LEFT JOIN distribution_centers dc
ON ii.product_distribution_center_id=dc.id
GROUP BY
	dc.id,
    dc.name
)
SELECT
	name,
    Category_Total
FROM DC_Category_Total
WHERE Category_Total =
(
	SELECT MAX(Category_Total)
    FROM DC_Category_Total
);

-- Q7. Which distribution center stores products from the most brands?

WITH DC_Brand_Total AS
(
	SELECT 
		dc.id,
		dc.name,
		COUNT(DISTINCT ii.product_brand) AS Total_Brands
	FROM inventory_items ii
	LEFT JOIN distribution_centers dc
	ON ii.product_distribution_center_id=dc.id
	GROUP BY 
		dc.id,
		dc.name
)
SELECT 
	name,
    Total_Brands
FROM DC_Brand_Total
WHERE Total_Brands =
(
	SELECT MAX(Total_Brands)
    FROM DC_Brand_Total
);

-- Q8. Which distribution center has more inventory than the average distribution center?

WITH Total_Inventory_Items AS
(
	SELECT 
		dc.id,
		dc.name,
		COUNT(*) AS Total_Items
	FROM inventory_items ii
	LEFT JOIN distribution_centers dc
	ON ii.product_distribution_center_id=dc.id
    GROUP BY 
		dc.id,
		dc.name
)
SELECT 
	id,
	name,
	Total_Items
FROM Total_Inventory_Items
WHERE Total_Items >
(
SELECT
	AVG(Total_Items) AS Average_Items
FROM Total_Inventory_Items
);

-- Q9. Which distribution center generated above-average revenue?

WITH DC_Total_Revenue AS
(
	SELECT 
		dc.id,
		dc.name,
		SUM(oi.sale_price) AS DC_Revenue
	FROM inventory_items ii
	INNER JOIN order_items oi
	ON ii.id=oi.inventory_item_id
	LEFT JOIN distribution_centers dc
	ON ii.product_distribution_center_id=dc.id
	GROUP BY
		dc.id,
		dc.name
)
SELECT
	id,
	name,
	DC_Revenue
FROM DC_Total_Revenue
WHERE DC_Revenue >
(
	SELECT
		AVG(DC_Revenue)
    FROM DC_Total_Revenue
);

-- Q10. Which distribution center has the best overall performance?

WITH DC_Total_Revenue AS
(
	SELECT 
		dc.id,
		dc.name,
		SUM(oi.sale_price) AS DC_Revenue
	FROM inventory_items ii
	INNER JOIN order_items oi
	ON ii.id=oi.inventory_item_id
	LEFT JOIN distribution_centers dc
	ON ii.product_distribution_center_id=dc.id
	GROUP BY
		dc.id,
		dc.name
),
DC_Sold_Items AS
(
    SELECT
        dc.id,
        dc.name,
        COUNT(*) AS Sold_Items
    FROM inventory_items ii
    INNER JOIN distribution_centers dc
        ON ii.product_distribution_center_id = dc.id
    WHERE ii.sold_at IS NOT NULL
    GROUP BY
        dc.id,
        dc.name
),
DC_Total_Items AS
(
    SELECT
        dc.id,
        dc.name,
        COUNT(*) AS Total_Items
    FROM inventory_items ii
    INNER JOIN distribution_centers dc
        ON ii.product_distribution_center_id = dc.id
    GROUP BY
        dc.id,
        dc.name
),
DC_Rate AS
(
    SELECT
        DC_Sold_Items.id,
        DC_Sold_Items.name,
        DC_Sold_Items.Sold_Items,
        DC_Total_Items.Total_Items,
        ROUND((DC_Sold_Items.Sold_Items / DC_Total_Items.Total_Items) * 100, 2)
            AS Sell_Through_Rate
    FROM DC_Sold_Items
    INNER JOIN DC_Total_Items
        ON DC_Sold_Items.id = DC_Total_Items.id
),
DC_Performance AS
(
    SELECT
        DC_Total_Revenue.id,
        DC_Total_Revenue.name,
        DC_Total_Revenue.DC_Revenue,
        DC_Rate.Sold_Items,
        DC_Rate.Total_Items,
        DC_Rate.Sell_Through_Rate,
        (
			DC_Revenue + 
			Sold_Items + 
			Sell_Through_Rate
        ) AS Performance_Score
    FROM DC_Total_Revenue
    INNER JOIN DC_Rate
        ON DC_Total_Revenue.id = DC_Rate.id
)
SELECT
    id,
    name,
    DC_Revenue,
    Sold_Items,
    Sell_Through_Rate,
	Performance_Score
FROM DC_Performance
WHERE Performance_Score=
(
	SELECT MAX(Performance_Score)
    FROM DC_Performance
);

-- ==========================================================================================================================
-- Level 8: Advanced SQL + Database Objects
-- ==========================================================================================================================

-- Q1. Assign a unique ranking to customers based on their total revenue.

WITH Customer_Total_Revenue AS 
(
	SELECT
		u.id,
		u.first_name,
		u.last_name,
		SUM(oi.sale_price) AS Customer_Revenue
	FROM order_items oi
	LEFT JOIN users u
	ON oi.user_id=u.id
	GROUP BY
		u.id,
		u.first_name,
		u.last_name
)
SELECT
	id,
    first_name,
    last_name,
    Customer_Revenue,
	ROW_NUMBER() OVER(ORDER BY Customer_Revenue DESC) AS Customer_Rank
FROM Customer_Total_Revenue;

-- Q2. Rank products based on total revenue while handling products with the same revenue appropriately.

WITH Product_Total_Revenue AS
(
SELECT
	p.id,
    p.name,
    SUM(oi.sale_price) AS Product_Revenue
FROM order_items oi
LEFT JOIN products p
ON oi.product_id=p.id
GROUP BY
	p.id,
    p.name
)
SELECT
	id,
    name,
    Product_Revenue,
	DENSE_RANK() OVER(ORDER BY Product_Revenue DESC) AS Product_Rank
FROM Product_Total_Revenue;


-- Q3. Find the highest revenue-generating customer from each country.

WITH Customer_Total_Revenue AS 
(
	SELECT
		u.id,
		u.first_name,
		u.last_name,
        u.country,
		SUM(oi.sale_price) AS Customer_Revenue
	FROM order_items oi
	LEFT JOIN users u
	ON oi.user_id=u.id
	GROUP BY
		u.id,
		u.first_name,
		u.last_name,
        u.country
),
Customer_Rank_Country AS
(
SELECT
	id,
    first_name,
    last_name,
    Customer_Revenue,
    country,
	DENSE_RANK() OVER(PARTITION BY country ORDER BY Customer_Revenue DESC) AS Customer_Rank
FROM Customer_Total_Revenue
)
SELECT
	id,
    first_name,
    last_name,
    Customer_Revenue,
    country,
	Customer_Rank
FROM Customer_Rank_Country
WHERE Customer_Rank = 1;

-- Q4. Display the cumulative revenue month by month.

WITH Monthly_Revenue AS
(
	SELECT 
		MONTH(created_at) Month_Number,
		MONTHNAME(created_at) AS Month_Name,
		SUM(sale_price) AS Revenue
	FROM order_items
	GROUP BY 
		Month_Number,
		Month_Name
)
SELECT
	Month_Name,
    Revenue,
    SUM(Revenue) OVER(ORDER BY Month_Number) AS Running_Total
FROM Monthly_Revenue;

-- Q5. Compare each month's revenue with the previous month's revenue.

WITH Monthly_Revenue AS
(
	SELECT 
		MONTH(created_at) Month_Number,
		MONTHNAME(created_at) AS Month_Name,
		SUM(sale_price) AS Revenue
	FROM order_items
	GROUP BY 
		Month_Number,
		Month_Name
),
Previous_Revenue AS
(
SELECT
	Month_Name,
    Revenue,
		LAG(Revenue) OVER(ORDER BY Month_Number) AS Previous_Month_Revenue
FROM Monthly_Revenue
)
SELECT
	Month_Name,
    Revenue,
	Previous_Month_Revenue,
    (Revenue-Previous_Month_Revenue) AS Difference
FROM Previous_Revenue;

-- Q6. Show the revenue difference between the current month and the next month.

WITH Monthly_Revenue AS
(
	SELECT 
		MONTH(created_at) Month_Number,
		MONTHNAME(created_at) AS Month_Name,
		SUM(sale_price) AS Revenue
	FROM order_items
	GROUP BY 
		Month_Number,
		Month_Name
),
Next_Revenue AS
(
SELECT
	Month_Name,
    Revenue,
		LEAD(Revenue) OVER(ORDER BY Month_Number) AS Next_Month_Revenue
FROM Monthly_Revenue
)
SELECT
	Month_Name,
    Revenue,
	Next_Month_Revenue,
	(Next_Month_Revenue-Revenue) AS Difference
FROM Next_Revenue;

-- Q7. Divide customers into four groups based on their total revenue.

WITH Customer_Total_Revenue AS 
(
	SELECT
		u.id,
		u.first_name,
		u.last_name,
		SUM(oi.sale_price) AS Customer_Revenue
	FROM order_items oi
	LEFT JOIN users u
	ON oi.user_id=u.id
	GROUP BY
		u.id,
		u.first_name,
		u.last_name
)
SELECT
	id,
    first_name,
    last_name,
    Customer_Revenue,
	NTILE(4) OVER(ORDER BY Customer_Revenue DESC) AS Revenue_Group
FROM Customer_Total_Revenue;

-- Q8. Create a customer performance report showing overall ranking, country-wise ranking, and revenue group.

WITH Customer_Total_Revenue AS 
(
	SELECT
		u.id,
		u.first_name,
		u.last_name,
        u.country,
		SUM(oi.sale_price) AS Customer_Revenue
	FROM order_items oi
	LEFT JOIN users u
	ON oi.user_id=u.id
	GROUP BY
		u.id,
		u.first_name,
		u.last_name,
		u.country
),
Customer_Rank AS
(
SELECT
	id,
    first_name,
    last_name,
    country,
    Customer_Revenue,
	ROW_NUMBER() OVER(ORDER BY Customer_Revenue DESC) AS Overall_Rank
FROM Customer_Total_Revenue
),
Country_Rank AS
(
SELECT
	id,
    first_name,
    last_name,
    Customer_Revenue,
    Overall_Rank,
    country,
	DENSE_RANK() OVER(PARTITION BY country ORDER BY Customer_Revenue DESC) AS Country_Rank
FROM Customer_Rank
)
SELECT
	id,
    first_name,
    last_name,
    Customer_Revenue,
    Overall_Rank,
    country,
	Country_Rank,
    NTILE(4) OVER(ORDER BY Customer_Revenue DESC) AS Revenue_Group
FROM Country_Rank;

-- Q9. Create a reusable report to display customer revenue details.

CREATE VIEW Customer_Revenue AS
SELECT
	u.id,
    u.first_name,
    u.last_name,
    SUM(oi.sale_price) AS Revenue
FROM order_items oi
LEFT JOIN users u
ON oi.user_id=u.id
GROUP BY
	u.id,
    u.first_name,
    u.last_name;

SELECT * FROM Customer_Revenue;


-- Q10. Create a reusable report to display distribution center performance.

CREATE VIEW DC_Performance AS 
WITH DC_Total_Revenue AS
(
	SELECT 
		dc.id,
		dc.name,
		SUM(oi.sale_price) AS DC_Revenue
	FROM inventory_items ii
	INNER JOIN order_items oi
	ON ii.id=oi.inventory_item_id
	LEFT JOIN distribution_centers dc
	ON ii.product_distribution_center_id=dc.id
	GROUP BY
		dc.id,
		dc.name
),
DC_Sold_Items AS
(
    SELECT
        dc.id,
        dc.name,
        COUNT(*) AS Sold_Items
    FROM inventory_items ii
    INNER JOIN distribution_centers dc
        ON ii.product_distribution_center_id = dc.id
    WHERE ii.sold_at IS NOT NULL
    GROUP BY
        dc.id,
        dc.name
),
DC_Total_Items AS
(
    SELECT
        dc.id,
        dc.name,
        COUNT(*) AS Total_Items
    FROM inventory_items ii
    INNER JOIN distribution_centers dc
        ON ii.product_distribution_center_id = dc.id
    GROUP BY
        dc.id,
        dc.name
),
DC_Rate AS
(
    SELECT
        DC_Sold_Items.id,
        DC_Sold_Items.name,
        DC_Sold_Items.Sold_Items,
        DC_Total_Items.Total_Items,
        ROUND((DC_Sold_Items.Sold_Items / DC_Total_Items.Total_Items) * 100, 2)
            AS Sell_Through_Rate
    FROM DC_Sold_Items
    INNER JOIN DC_Total_Items
        ON DC_Sold_Items.id = DC_Total_Items.id
),
Distribution_Center_Performance AS
(
    SELECT
        DC_Total_Revenue.id,
        DC_Total_Revenue.name,
        DC_Total_Revenue.DC_Revenue,
        DC_Rate.Sold_Items,
        DC_Rate.Total_Items,
        DC_Rate.Sell_Through_Rate,
        (
			DC_Revenue + 
			Sold_Items + 
			Sell_Through_Rate
        ) AS Performance_Score
    FROM DC_Total_Revenue
    INNER JOIN DC_Rate
        ON DC_Total_Revenue.id = DC_Rate.id
)
SELECT
    id,
    name,
    DC_Revenue,
    Sold_Items,
    Total_Items,
    Sell_Through_Rate,
    Performance_Score
FROM Distribution_Center_Performance;

SELECT * FROM DC_Performance;

-- Q11. Create a reusable database program to display monthly revenue.

DELIMITER ##
CREATE PROCEDURE Monthly_Revenue ()
BEGIN
SELECT 
	MONTHNAME(created_at) AS Month_Name,
    SUM(sale_price) AS Revenue
FROM order_items
GROUP BY
	Month_Name,
    MONTH(created_at)
ORDER BY
    MONTH(created_at);
END ##
DELIMITER ;

CALL Monthly_Revenue;

-- Q12. Create a reusable database program that displays the revenue of a specific customer.

DELIMITER ##
CREATE PROCEDURE Customer_Revenue(IN customer_id INT)
BEGIN
SELECT
	u.id,
    u.first_name,
    u.last_name,
    SUM(oi.sale_price) AS Revenue
FROM order_items oi
LEFT JOIN users u
ON oi.user_id=u.id
WHERE u.id=customer_id
GROUP BY
	u.id,
    u.first_name,
    u.last_name;
END ##
DELIMITER ;

CALL Customer_Revenue(1561);

-- Q13. Create a reusable database program to classify customers as High, Medium, or Low revenue.

DELIMITER $$
CREATE PROCEDURE Customer_Category
(
    IN p_customer_id INT,
    OUT p_customer_category VARCHAR(20)
)
BEGIN
    DECLARE Total_Revenue DECIMAL(10,2);
    SELECT
        SUM(oi.sale_price)
    INTO Total_Revenue
    FROM order_items oi
    WHERE oi.user_id = p_customer_id;
    IF Total_Revenue >= 1000 THEN
        SET p_customer_category = 'High';
    ELSEIF Total_Revenue >= 100 THEN
        SET p_customer_category = 'Medium';
    ELSE
        SET p_customer_category = 'Low';
    END IF;
END $$
DELIMITER ;
    
CALL Customer_Category(1561, @Customer_Category);
SELECT @Customer_Category;

-- Q14. Design a suppliers table with appropriate constraints to ensure data integrity.

CREATE TABLE suppliers
(
	supplier_id INT AUTO_INCREMENT PRIMARY KEY,
	supplier_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE,
    country VARCHAR(20) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Active','Inactive')) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Q15. Improve the performance of one of your existing business queries and explain why the new approach is better.

CREATE INDEX idx_order_items_user_id
ON order_items(user_id);

EXPLAIN
SELECT
    u.id,
    u.first_name,
    SUM(oi.sale_price) AS Revenue
FROM users u
INNER JOIN order_items oi
ON u.id = oi.user_id
GROUP BY
    u.id,
    u.first_name;


CREATE INDEX idx_orders_user_id
ON orders(user_id);

CREATE INDEX idx_order_items_orders_id
ON order_items(order_id);

CREATE INDEX idx_order_items_product_id
ON order_items(product_id);

CREATE INDEX idx_order_items_inventory_item_id
ON order_items(inventory_item_id);

CREATE INDEX idx_inventory_items_product_id
ON inventory_items(product_id);

CREATE INDEX idx_inventory_items_distribution_center_id
ON inventory_items(product_distribution_center_id);
