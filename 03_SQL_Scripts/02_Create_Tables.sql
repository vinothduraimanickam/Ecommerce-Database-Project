/*
==========================================
File : 02_Create_Tables.sql
Project : E-Commerce Database Project
Author : Vinoth D
Database : ecommerce_project_01_db
Description : Creates all project tables.
==========================================
*/

-- ==========================================================================================================================
-- USERS TABLE
-- ==========================================================================================================================

CREATE TABLE users (
    id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(20) NOT NULL,
    state VARCHAR(50) NOT NULL,
    street_address VARCHAR(255) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    city VARCHAR(50) NULL,
    country VARCHAR(50) NOT NULL,
    latitude DECIMAL(9,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
    traffic_source VARCHAR(50) NOT NULL,
    created_at VARCHAR(50) NOT NULL,
    
    PRIMARY KEY (id)
);

-- ==========================================================================================================================
-- ORDERS TABLE
-- ==========================================================================================================================

CREATE TABLE orders (
	order_id INT NOT NULL,
    user_id INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    gender VARCHAR(20) NOT NULL,
    created_at VARCHAR(50) NOT NULL,
    returned_at VARCHAR(50) NULL,
    shipped_at VARCHAR(50) NULL,
    delivered_at VARCHAR(50) NULL,
    num_of_item INT NOT NULL,
    
    PRIMARY KEY (order_id)
);

-- ==========================================================================================================================
-- ORDER_ITEMS TABLE
-- ==========================================================================================================================

drop TABLE order_items

CREATE TABLE order_items (
	id INT NOT NULL,
	order_id INT NOT NULL,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    inventory_item_id INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at VARCHAR(50) NOT NULL,
    shipped_at VARCHAR(50) NULL,
    delivered_at VARCHAR(50) NULL,
    returned_at VARCHAR(50) NULL,
    sale_price DECIMAL(9,2) NOT NULL,
    
    PRIMARY KEY (id)
);

-- ==========================================================================================================================
-- PRODUCTS TABLE
-- ==========================================================================================================================

CREATE TABLE products (
	id INT NOT NULL,
    cost DECIMAL(9,2) NOT NULL,
    category VARCHAR(50) NOT NULL,
    name VARCHAR(255) NULL,
    brand VARCHAR(50) NULL,
    retail_price DECIMAL(9,2) NOT NULL,
	department VARCHAR(50) NOT NULL,
	sku VARCHAR(200) NOT NULL,
    distribution_center_id INT NOT NULL,
	
    PRIMARY KEY (id)
);

-- ==========================================================================================================================
-- INVENTORY_ITEMS TABLE
-- ==========================================================================================================================

CREATE TABLE inventory_items (
	id INT NOT NULL,
	product_id INT NOT NULL,
    created_at VARCHAR(50) NOT NULL,
    sold_at VARCHAR(50) NULL,
    cost DECIMAL(9,2) NOT NULL,
    product_category VARCHAR(50) NOT NULL,
	product_name VARCHAR(255) NULL,
    product_brand VARCHAR(50) NULL,
    product_retail_price DECIMAL(9,2) NOT NULL,
    product_department VARCHAR(50) NOT NULL,
	product_sku VARCHAR(200) NOT NULL,
    product_distribution_center_id INT NOT NULL,
    
    PRIMARY KEY (id)
);

-- ==========================================================================================================================
-- DISTRIBUTION_CENTERS TABLE
-- ==========================================================================================================================

CREATE TABLE distribution_centers (
	id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    latitude DECIMAL(9,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
	
    PRIMARY KEY (id)
);
