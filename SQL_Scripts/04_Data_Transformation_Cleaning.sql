/*
==========================================
File : 04_Data_Transformation_Cleaning.sql
Project : E-Commerce Database Project
Author : Vinoth D
Database : ecommerce_project_01_db
Description : Data Transformation and Cleaning.
==========================================
*/

-- ==========================================================================================================================
-- Replace "null" with SQL NULL
-- ==========================================================================================================================

UPDATE users
SET city = NULL
WHERE UPPER(city)='NULL';

-- ==========================================================================================================================
-- Replace '' with SQL NULL
-- ==========================================================================================================================

UPDATE products
SET name=NULL
WHERE name='';

UPDATE products
SET brand=NULL
WHERE brand='';

UPDATE orders
SET returned_at=NULL
WHERE returned_at='';

UPDATE orders
SET shipped_at=NULL
WHERE shipped_at='';

UPDATE orders
SET delivered_at=NULL
WHERE delivered_at='';


UPDATE order_items
SET shipped_at=NULL
WHERE shipped_at='';

UPDATE order_items
SET delivered_at=NULL
WHERE delivered_at='';

UPDATE order_items
SET returned_at=NULL
WHERE returned_at='';

UPDATE inventory_items
SET sold_at=NULL
WHERE sold_at='';

UPDATE inventory_items
SET product_name=NULL
WHERE product_name='';

UPDATE inventory_items
SET product_brand=NULL
WHERE product_brand='';

-- ==========================================================================================================================
-- Remove UTC timezone
-- ==========================================================================================================================

UPDATE users
SET created_at=REPLACE(created_at,'+00:00','');

UPDATE orders
SET created_at   = REPLACE(created_at, '+00:00', ''),
    returned_at  = REPLACE(returned_at, '+00:00', ''),
    shipped_at   = REPLACE(shipped_at, '+00:00', ''),
    delivered_at = REPLACE(delivered_at, '+00:00', '');
    
UPDATE order_items
SET created_at   = REPLACE(created_at, '+00:00', ''),
    shipped_at   = REPLACE(shipped_at, '+00:00', ''),
    delivered_at = REPLACE(delivered_at, '+00:00', ''),
    returned_at  = REPLACE(returned_at, '+00:00', '');
    
UPDATE inventory_items
SET created_at   = REPLACE(created_at, '+00:00', ''),
    sold_at   = REPLACE(sold_at, '+00:00', '');

-- ==========================================================================================================================
-- Convert VARCHAR to DATETIME in Date Fields
-- ==========================================================================================================================

ALTER TABLE users
MODIFY created_at DATETIME NOT NULL;

ALTER TABLE orders
MODIFY created_at DATETIME NOT NULL,
MODIFY returned_at DATETIME NULL,
MODIFY shipped_at DATETIME NULL,
MODIFY delivered_at DATETIME NULL;

ALTER TABLE order_items
MODIFY created_at DATETIME NOT NULL,
MODIFY shipped_at DATETIME NULL,
MODIFY delivered_at DATETIME NULL,
MODIFY returned_at DATETIME NULL;

ALTER TABLE inventory_items
MODIFY created_at DATETIME NOT NULL,
MODIFY sold_at DATETIME NULL;