DROP DATABASE IF EXISTS Session03;
CREATE DATABASE Session03;
USE Session03;

CREATE TABLE Subject(
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(50) UNIQUE NOT NULL,
    credits INT CHECK (credits > 0)
);

CREATE TABLE Student (
    student_id CHAR(10) PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    date_of_birthday DATE,
    email VARCHAR(50) UNIQUE
);

CREATE TABLE Enrollment(
    subject_id INT NOT NULL,
    student_id CHAR(10) NOT NULL,
    enroll_date DATE NOT NULL,
    PRIMARY KEY (subject_id, student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE Score(
    student_id CHAR(10) NOT NULL,
    subject_id INT NOT NULL,
    mid_score DECIMAL(4,2) CHECK (mid_score BETWEEN 0 AND 10),
    final_score DECIMAL(4,2) CHECK (final_score BETWEEN 0 AND 10),
    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);

-- Thêm mới học sinh
INSERT INTO Student VALUES 
('MS01','Phạm Thị Hồng Nhung','2006-12-13','pthongnhung13122006@gmail.com'),
('MS02','Phạm Thị Hồng Nhung','2006-12-13','pthongnhung13122005@gmail.com'),
('MS03','Phạm Thị Hồng Nhung','2006-12-13','pthongnhung13122004@gmail.com'),
('MS05','Phạm Thị HNhung','2006-12-13','pthongnhung13122003@gmail.com');

-- Thêm mới môn học
INSERT INTO Subject (subject_name, credits) VALUES
('CSDL',3),
('C',5),
('Java',4),
('Python',4);

-- Thêm mới thông tin đăng kí môn học
INSERT INTO Enrollment VALUES
(1, 'MS01', '2024-09-01'),
(3, 'MS01', '2024-09-01'),
(2, 'MS02', '2024-09-01'),
(4, 'MS03', '2024-09-01');

-- Thêm mới bảng điểm
INSERT INTO Score VALUES
('MS01', 1, 9, 9.5),
('MS02', 1, 9, 9.5),
('MS03', 2, 8, 6);

-- Cập nhật điểm cuối kỳ cho một sinh viên;
UPDATE Score SET final_score = 10 where student_id = 'MS01';
-- Lấy ra toàn bộ bảng điểm;
SELECT * FROM Score;
-- Lấy ra các sinh viên có điểm cuối kỳ từ 8 trở lên;
SELECT 
	s.student_id,
	s.full_name,
	sub. subject_id,
	sub. subject_name,
	sc. final_score
FROM Score sc
JOIN Student s ON sc.student_id = s.student_id
JOIN Subject sub ON sc.subject_id = sub.subject_id
Where sc.final_score >= 8;

-- lấy danh sách học sinh đăng kí môn học
SELECT 
    s.student_id,
    s.full_name,
    sub.subject_name,
    sub.credits,
    e.enroll_date
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Subject sub ON e.subject_id = sub.subject_id
WHERE s.student_id = 'MS01';

-- Cập nhật môn học 
UPDATE Subject SET credits = 10 WHERE subject_id = 1;
UPDATE Subject SET subject_name = 'JavaScript' WHERE subject_id = 4;

-- Xóa một một học sinh không hợp lệ
DELETE FROM Student WHERE student_id = 'MS05'
