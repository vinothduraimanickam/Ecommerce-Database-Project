/*
==========================================
File : 05_Add_Foreign_Keys.sql
Project : E-Commerce Database Project
Author : Vinoth D
Database : ecommerce_project_01_db
Description : Add Foreign Keys to tables.
==========================================
*/

-- ==========================================================================================================================
-- FOREIGN KEY FOR ORDERS TO USERS TABLES
-- ==========================================================================================================================

ALTER TABLE orders
ADD CONSTRAINT fk_orders_users
FOREIGN KEY (user_id)
REFERENCES users(id);

-- ==========================================================================================================================
-- FOREIGN KEY FOR ORDER_ITEMS TO ORDERS TABLES
-- ==========================================================================================================================

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- ==========================================================================================================================
-- FOREIGN KEY FOR ORDER_ITEMS TO PRODUCTS TABLES
-- ==========================================================================================================================

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (product_id)
REFERENCES products(id);

-- ==========================================================================================================================
-- FOREIGN KEY FOR ORDER_ITEMS TO USERS TABLES
-- ==========================================================================================================================

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_users
FOREIGN KEY (user_id)
REFERENCES users(id);

-- ==========================================================================================================================
-- FOREIGN KEY FOR ORDER_ITEMS TO INVENTORY_ITEMS TABLES
-- ==========================================================================================================================

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_inventory_items
FOREIGN KEY (inventory_item_id)
REFERENCES inventory_items(id);

-- ==========================================================================================================================
-- FOREIGN KEY FOR PRODUCTS TO DISTRIBUTION_CENTER TABLES
-- ==========================================================================================================================

ALTER TABLE products
ADD CONSTRAINT fk_products_distribution_centers
FOREIGN KEY (distribution_center_id)
REFERENCES distribution_centers(id);

-- ==========================================================================================================================
-- FOREIGN KEY FOR INVENTORY_ITEMS TO PRODUCTS TABLES
-- ==========================================================================================================================

ALTER TABLE inventory_items
ADD CONSTRAINT fk_inventory_items_products
FOREIGN KEY (product_id)
REFERENCES products(id);

-- ==========================================================================================================================
-- FOREIGN KEY FOR INVENTORY_ITEMS TO DISTRIBUTION_CENTER TABLES
-- ==========================================================================================================================

ALTER TABLE inventory_items
ADD CONSTRAINT fk_inventory_items_product_distribution_center_id
FOREIGN KEY (product_distribution_center_id)
REFERENCES distribution_centers(id);