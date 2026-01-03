DROP DATABASE IF EXISTS Session05;
CREATE DATABASE Session05;
USE Session05;
CREATE TABLE orders (
    order_id INT  PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10,2),
    order_date DATE,
    status ENUM('pending', 'completed', 'cancelled')
);

INSERT INTO orders (order_id, customer_id, total_amount, order_date, status) VALUES
(1, 1, 2500000.00, '2024-01-10', 'completed'),
(2, 2, 1800000.00, '2024-01-12', 'pending'),
(3, 3, 3200000.00, '2024-01-15', 'completed'),
(4, 1, 1500000.00, '2024-01-18', 'cancelled'),
(5, 4, 4200000.00, '2024-01-20', 'completed'),
(6, 5, 900000.00,  '2024-01-22', 'pending'),
(7, 6, 2750000.00, '2024-01-25', 'completed'),
(8, 2, 3600000.00, '2024-01-27', 'cancelled'),
(9, 7, 5100000.00, '2024-01-29', 'completed'),
(10, 3, 1300000.00,'2024-02-01', 'pending'),
(11, 4, 6800000.00, '2024-02-03', 'completed'),
(12, 5, 2400000.00, '2024-02-05', 'pending'),
(13, 6, 8900000.00, '2024-02-07', 'completed'),
(14, 2, 3100000.00, '2024-02-10', 'cancelled'),
(15, 7, 5600000.00, '2024-02-12', 'completed'),
(16, 1, 1950000.00, '2024-02-15', 'pending');

SELECT * FROM Orders
LIMIT 5;
SELECT * FROM Orders
LIMIT 5 OFFSET 5;
SELECT * FROM Orders
LIMIT 5 OFFSET 10;
SELECT * FROM Orders
WHERE status = 'cancelled'

