START TRANSACTION;

-- Drop tables in correct order to avoid FK conflicts
DROP TABLE IF EXISTS order_item;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS location_menu;
DROP TABLE IF EXISTS menu;
 DROP TABLE IF EXISTS inventory;
 DROP TABLE IF EXISTS royalty;
 DROP TABLE IF EXISTS loyalty_accounts;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS location;

-- =========================
-- location
-- =========================
CREATE TABLE location (
    id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(2),
    zip VARCHAR(10)
);

-- =========================
-- customer
-- =========================
CREATE TABLE customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    f_name VARCHAR(50),
    l_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(45),
    member_since DATE
);

-- =========================
-- inventory
-- =========================
CREATE TABLE inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item VARCHAR(60),
    quantity INT,
    last_received DATE,
    supplier_id INT
);

-- =========================
-- menu
-- =========================
CREATE TABLE menu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item VARCHAR(60),
    price INT,
    inventory_id INT,
    FOREIGN KEY (inventory_id) REFERENCES inventory(id)
);

-- =========================
-- location_menu (junction table)
-- =========================
CREATE TABLE location_menu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    location_id INT,
    menu_id INT,
    is_included BOOLEAN,
    FOREIGN KEY (location_id) REFERENCES location(id),
    FOREIGN KEY (menu_id) REFERENCES menu(id)
);

-- =========================
-- orders
-- =========================
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    location_id INT,
    order_date DATE,
    total_cost INT,
    customer_id INT,
    FOREIGN KEY (location_id) REFERENCES location(id),
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

-- =========================
-- order_item
-- =========================
CREATE TABLE order_item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    menu_item VARCHAR(100),
    quantity INT,
    price INT,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- =========================
-- order_item
-- =========================

CREATE TABLE loyalty_accounts (
    loyalty_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL UNIQUE,
    points_balance INT DEFAULT 0,
    tier VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);
-- ROLLBACK;
COMMIT;

SELECT * FROM customer;
SELECT * FROM location;
select * from menu;

