/*
==========================================
File : 06_Data_Validation.sql
Project : E-Commerce Database Project
Author : Vinoth D
Database : ecommerce_project_01_db
Description : Data Validation.
==========================================
*/

-- ==========================================================================================================================
-- Row Count Validation
-- ==========================================================================================================================

SELECT COUNT(*) AS users_count FROM users;
SELECT COUNT(*) AS orders_count FROM orders;
SELECT COUNT(*) AS order_items_count FROM order_items;
SELECT COUNT(*) AS products_count FROM products;
SELECT COUNT(*) AS inventory_items_count FROM inventory_items;
SELECT COUNT(*) AS distribution_centers_count FROM distribution_centers;

-- ==========================================================================================================================
-- Primary Key Validation
-- ==========================================================================================================================

SELECT id, COUNT(*) FROM users
GROUP BY id
HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*) FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT id, COUNT(*) FROM order_items
GROUP BY id
HAVING COUNT(*) > 1;

SELECT id, COUNT(*) FROM products
GROUP BY id
HAVING COUNT(*) > 1;

SELECT id, COUNT(*) FROM inventory_items
GROUP BY id
HAVING COUNT(*) > 1;

SELECT id, COUNT(*) FROM distribution_centers
GROUP BY id
HAVING COUNT(*) > 1;

-- ==========================================================================================================================
-- Foreign Key Validation
-- ==========================================================================================================================

SELECT COUNT(*) FROM orders o
LEFT JOIN users u
ON o.user_id = u.id
WHERE u.id IS NULL;

SELECT COUNT(*) FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*) FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.id
WHERE p.id IS NULL;

SELECT COUNT(*) FROM order_items oi
LEFT JOIN users u
ON oi.user_id = u.id
WHERE u.id IS NULL;

SELECT COUNT(*) FROM order_items oi
LEFT JOIN inventory_items ii
ON oi.inventory_item_id = ii.id
WHERE ii.id IS NULL;

SELECT COUNT(*) FROM products p
LEFT JOIN distribution_centers dc
ON p.distribution_center_id = dc.id
WHERE dc.id IS NULL;

SELECT COUNT(*) FROM inventory_items ii
LEFT JOIN products p
ON ii.product_id = p.id
WHERE p.id IS NULL;

SELECT COUNT(*) FROM inventory_items ii
LEFT JOIN distribution_centers dc
ON ii.product_distribution_center_id = dc.id
WHERE dc.id IS NULL;

-- ==========================================================================================================================
-- NULL Validation
-- ==========================================================================================================================

SELECT COUNT(*) FROM users
WHERE id IS NULL;

SELECT COUNT(*) FROM users
WHERE first_name IS NULL;

SELECT COUNT(*) FROM users
WHERE last_name IS NULL;

SELECT COUNT(*) FROM users
WHERE email IS NULL;

SELECT COUNT(*) FROM users
WHERE created_at IS NULL;

SELECT COUNT(*) FROM orders
WHERE order_id IS NULL;

SELECT COUNT(*) FROM orders
WHERE user_id IS NULL;

SELECT COUNT(*) FROM orders
WHERE status IS NULL;

SELECT COUNT(*) FROM orders
WHERE created_at IS NULL;

SELECT COUNT(*) FROM products
WHERE id IS NULL;

SELECT COUNT(*) FROM products
WHERE cost IS NULL;

SELECT COUNT(*) FROM products
WHERE category IS NULL;

SELECT COUNT(*) FROM products
WHERE retail_price IS NULL;

SELECT COUNT(*) FROM products
WHERE department IS NULL;

SELECT COUNT(*) FROM products
WHERE sku IS NULL;

SELECT COUNT(*) FROM products
WHERE distribution_center_id IS NULL;

-- ==========================================================================================================================
-- Domain Validation
-- ==========================================================================================================================

SELECT DISTINCT gender FROM users;
SELECT DISTINCT state FROM users;
SELECT DISTINCT country FROM users;
SELECT DISTINCT traffic_source FROM users;

SELECT DISTINCT status FROM orders;
SELECT DISTINCT gender FROM orders;

SELECT DISTINCT status FROM order_items;

SELECT DISTINCT category FROM products;
SELECT DISTINCT brand FROM products;
SELECT DISTINCT department FROM products;

SELECT DISTINCT product_category FROM inventory_items;
SELECT DISTINCT product_brand FROM inventory_items;
SELECT DISTINCT product_department FROM inventory_items;

-- ==========================================================================================================================
-- Date Validation
-- ==========================================================================================================================

SELECT
MIN(created_at),
MAX(created_at)
FROM users;

SELECT
MIN(created_at),
MAX(created_at)
FROM orders;

SELECT
MIN(shipped_at),
MAX(shipped_at)
FROM orders;

SELECT
MIN(delivered_at),
MAX(delivered_at)
FROM orders;

SELECT
MIN(returned_at),
MAX(returned_at)
FROM orders;

SELECT
MIN(created_at),
MAX(created_at)
FROM order_items;

SELECT
MIN(shipped_at),
MAX(shipped_at)
FROM order_items;

SELECT
MIN(delivered_at),
MAX(delivered_at)
FROM order_items;

SELECT
MIN(returned_at),
MAX(returned_at)
FROM order_items;

SELECT
MIN(created_at),
MAX(created_at)
FROM inventory_items;

SELECT
MIN(sold_at),
MAX(sold_at)
FROM inventory_items;

