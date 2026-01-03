DROP DATABASE IF EXISTS Session05;
CREATE DATABASE Session05;
USE Session05;
CREATE TABLE Customers(
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255),
    email VARCHAR(255),
    city VARCHAR(255),
     status ENUM('ACTIVE', 'INACTIVE') 
);

INSERT INTO customers (full_name, email, city, status) VALUES
('Nguyễn Văn An', 'an.nguyen@gmail.com', 'Hà Nội', 'ACTIVE'),
('Trần Thị Bình', 'binh.tran@yahoo.com', 'TP. Hồ Chí Minh', 'ACTIVE'),
('Lê Quốc Cường', 'cuong.le@outlook.com', 'Đà Nẵng', 'INACTIVE'),
('Phạm Thị Dung', 'dung.pham@gmail.com', 'Hải Phòng', 'ACTIVE'),
('Hoàng Minh Đức', 'duc.hoang@gmail.com', 'Cần Thơ', 'ACTIVE'),
('Vũ Thị Hạnh', 'hanh.vu@yahoo.com', 'Bắc Ninh', 'INACTIVE'),
('Phạm Thị Hồng Nhung', 'pthongnhung13122006', 'TP. Hồ Chí Minh', 'ACTIVE'),
('Đặng Văn Khoa', 'khoa.dang@gmail.com', 'Nghệ An', 'ACTIVE');

SELECT * FROM Customers
WHERE city = 'TP. Hồ Chí Minh';
-- Lấy khách hàng đang hoạt động và ở Hà Nội;
SELECT * FROM Customers
WHERE city = 'HÀ nội';
-- Xắp xếp danh sách theo tên từ ( A - Z)
SELECT * FROM Customers
ORDER BY SUBSTRING_INDEX(full_name, ' ', -1);
