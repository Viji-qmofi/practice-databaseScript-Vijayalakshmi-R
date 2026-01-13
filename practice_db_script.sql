-- Start transaction
START TRANSACTION;

-- Drop tables if they already exist (order matters because of foreign keys)
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- Create customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Create products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(8,2) NOT NULL
);

-- Create orders table (foreign keys)
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    order_date DATE NOT NULL,
    quantity INT NOT NULL
 );

-- Insert data into customers
INSERT INTO customers (first_name, last_name, email) VALUES
('John', 'Doe', 'john.doe@email.com'),
('Jane', 'Smith', 'jane.smith@email.com');

-- Insert data into products
INSERT INTO products (product_name, price) VALUES
('Laptop', 999.99),
('Mouse', 25.50);

-- Insert data into orders
INSERT INTO orders (customer_id, product_id, order_date, quantity) VALUES
(1, 1, '2026-01-10', 1),
(2, 2, '2026-01-11', 2);

-- Commit transaction
COMMIT;

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

