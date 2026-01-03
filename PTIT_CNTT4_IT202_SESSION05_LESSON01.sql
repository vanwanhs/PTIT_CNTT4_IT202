DROP DATABASE IF EXISTS Session05;
CREATE DATABASE Session05;
USE Session05;
CREATE TABLE Products(
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2),
    stock INT NOT NULL,
    status ENUM('ACTIVE', 'INACTIVE')
);

INSERT INTO products (product_name, price, stock, status) VALUES
('Laptop Dell Inspiron 15', 18500000.00, 10, 'ACTIVE'),
('Chuột Logitech M331', 350000.00, 50, 'ACTIVE'),
('Bàn phím cơ Keychron K2', 2200000.00, 20, 'ACTIVE'),
('Tai nghe Sony WH-1000XM4', 6200000.00, 5, 'INACTIVE'),
('Màn hình Samsung 24 inch', 4200000.00, 8, 'ACTIVE');

SELECT * FROM Products
WHERE status = 'ACTIVE' AND price > 1000000
ORDER BY price