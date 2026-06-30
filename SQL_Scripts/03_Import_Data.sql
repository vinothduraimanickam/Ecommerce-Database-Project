/*
==========================================
File : 03_Import_Data.sql
Project : E-Commerce Database Project
Author : Vinoth D
Database : ecommerce_project_01_db
Description : Import Data to tables.
==========================================
*/

-- ==========================================================================================================================
-- USERS
-- ==========================================================================================================================

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv'
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, first_name, last_name, email, age, gender, state, street_address, postal_code, city, country, latitude, longitude, traffic_source, created_at);

-- ==========================================================================================================================
-- PRODUCTS
-- ==========================================================================================================================

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, cost, category, name, brand, retail_price, department, sku, distribution_center_id);

-- ==========================================================================================================================
-- ORDERS
-- ==========================================================================================================================

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, user_id, status, gender, created_at, returned_at, shipped_at, delivered_at, num_of_item);

-- ==========================================================================================================================
-- ORDER_ITEMS
-- ==========================================================================================================================

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_items.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, order_id, user_id, product_id, inventory_item_id, status, created_at, shipped_at, delivered_at, returned_at, sale_price);

-- ==========================================================================================================================
-- DISTRIBUTION_CENTERS
-- ==========================================================================================================================

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/distribution_centers.csv'
INTO TABLE distribution_centers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, name, latitude, longitude);

-- ==========================================================================================================================
-- INVENTORY_ITEMS
-- ==========================================================================================================================

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/inventory_items.csv'
INTO TABLE inventory_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, product_id,created_at,sold_at, cost, product_category, product_name, product_brand, product_retail_price, product_department, product_sku, product_distribution_center_id);