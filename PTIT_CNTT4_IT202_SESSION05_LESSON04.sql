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

ALTER TABLE products
ADD sold_quantity INT;
INSERT INTO products (product_name, price, stock, sold_quantity, status) VALUES
('Laptop HP Pavilion 14', 17200000.00, 12, 30, 'ACTIVE'),
('Laptop Asus Vivobook 15', 15900000.00, 15, 25, 'ACTIVE'),
('MacBook Air M1', 24500000.00, 7, 40, 'ACTIVE'),
('Chuột Logitech G102', 450000.00, 60, 120, 'ACTIVE'),
('Chuột không dây Xiaomi', 250000.00, 80, 200, 'ACTIVE'),
('Bàn phím Logitech K380', 850000.00, 35, 55, 'ACTIVE'),
('Bàn phím cơ Akko 3068', 1800000.00, 18, 22, 'ACTIVE'),
('Tai nghe AirPods 2', 3200000.00, 10, 75, 'ACTIVE'),
('Tai nghe JBL Tune 510BT', 1200000.00, 25, 90, 'ACTIVE'),
('Màn hình LG 27 inch', 5200000.00, 6, 15, 'ACTIVE'),
('Màn hình Dell 22 inch', 3900000.00, 9, 18, 'ACTIVE'),
('Ổ cứng SSD Samsung 970 EVO 1TB', 2800000.00, 20, 65, 'ACTIVE'),
('Ổ cứng SSD Kingston 512GB', 1350000.00, 30, 110, 'ACTIVE'),
('USB Sandisk 64GB', 180000.00, 100, 300, 'ACTIVE'),
('Webcam Logitech C920', 2100000.00, 14, 28, 'INACTIVE');

-- Lấy 5 sản phẩm bán chạy tiếp theo (bỏ qua 10 sản phẩm đầu)
SELECT * FROM Products
LIMIT 10 OFFSET 10;
-- Hiển thị danh sách sản phẩm giá < 2.000.000, sắp xếp theo số lượng bán giảm dần
SELECT * FROM Products
WHERE price < 2000000
ORDER BY sold_quantity DESC

