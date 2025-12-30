

DROP DATABASE IF EXISTS online_learning;
CREATE DATABASE online_learning;
USE online_learning;

CREATE TABLE Student (
  student_id INT PRIMARY KEY,
  full_name  VARCHAR(100) NOT NULL,
  dob        DATE,
  email      VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Teacher (
  teacher_id INT PRIMARY KEY,
  full_name  VARCHAR(100) NOT NULL,
  email      VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Course (
  course_id      INT PRIMARY KEY,
  course_name    VARCHAR(150) NOT NULL,
  description    VARCHAR(255),
  total_sessions INT NOT NULL CHECK (total_sessions > 0),
  teacher_id     INT NOT NULL,
  FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

CREATE TABLE Enrollment (
  student_id  INT NOT NULL,
  course_id   INT NOT NULL,
  enroll_date DATE NOT NULL,
  PRIMARY KEY (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES Student(student_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES Course(course_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Result (
  student_id  INT NOT NULL,
  course_id   INT NOT NULL,
  mid_score   DECIMAL(4,2) NOT NULL CHECK (mid_score >= 0 AND mid_score <= 10),
  final_score DECIMAL(4,2) NOT NULL CHECK (final_score >= 0 AND final_score <= 10),
  PRIMARY KEY (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES Student(student_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES Course(course_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

INSERT INTO Student (student_id, full_name, dob, email) VALUES
(1, 'Nguyễn Văn An',  '2003-05-10', 'an.nguyen@gmail.com'),
(2, 'Trần Thị Bình',  '2004-08-22', 'binh.tran@gmail.com'),
(3, 'Lê Văn Cường',   '2003-12-01', 'cuong.le@gmail.com'),
(4, 'Phạm Thị Dung',  '2004-03-15', 'dung.pham@gmail.com'),
(5, 'Hoàng Minh Đức', '2003-09-09', 'duc.hoang@gmail.com');

INSERT INTO Teacher (teacher_id, full_name, email) VALUES
(101, 'ThS. Nguyễn Hải', 'hai.nguyen@uni.edu'),
(102, 'ThS. Trần Lan',   'lan.tran@uni.edu'),
(103, 'ThS. Lê Quang',   'quang.le@uni.edu'),
(104, 'ThS. Phạm Hương', 'huong.pham@uni.edu'),
(105, 'ThS. Hoàng Sơn',  'son.hoang@uni.edu');

INSERT INTO Course (course_id, course_name, description, total_sessions, teacher_id) VALUES
(201, 'SQL Cơ bản',        'Học SELECT/INSERT/UPDATE/DELETE', 10, 101),
(202, 'SQL Nâng cao',      'JOIN, Subquery, Index',            12, 103),
(203, 'Thiết kế CSDL',     'ERD, chuẩn hóa dữ liệu',           8,  102),
(204, 'Web Backend',       'API + Database',                   14, 104),
(205, 'Kiểm thử phần mềm', 'Test case, bug report',            9,  105);

INSERT INTO Enrollment (student_id, course_id, enroll_date) VALUES
(1, 201, '2024-08-05'),
(1, 203, '2024-08-06'),
(2, 201, '2024-08-05'),
(2, 204, '2024-08-07'),
(3, 202, '2024-08-08'),
(3, 203, '2024-08-08'),
(4, 205, '2024-08-09'),
(5, 201, '2024-08-10');

INSERT INTO Result (student_id, course_id, mid_score, final_score) VALUES
(1, 201, 7.50, 8.00),
(1, 203, 8.00, 8.50),
(2, 201, 6.50, 7.00),
(2, 204, 7.00, 7.50),
(3, 202, 8.50, 9.00),
(3, 203, 7.50, 8.00),
(4, 205, 6.00, 6.50),
(5, 201, 5.50, 6.00);

UPDATE Student
SET email = 'an.nguyen.new@gmail.com'
WHERE student_id = 1;

UPDATE Course
SET description = 'JOIN, Subquery, Index, View, Procedure'
WHERE course_id = 202;

UPDATE Result
SET final_score = 8.75
WHERE student_id = 2 AND course_id = 204;

DELETE FROM Enrollment
WHERE student_id = 5 AND course_id = 201;

DELETE FROM Result
WHERE student_id = 5 AND course_id = 201;

SELECT * FROM Student;

SELECT * FROM Teacher;

SELECT
  c.course_id, c.course_name, c.description, c.total_sessions,
  t.teacher_id, t.full_name AS teacher_name, t.email AS teacher_email
FROM Course c
JOIN Teacher t ON c.teacher_id = t.teacher_id;

SELECT
  e.student_id, s.full_name AS student_name,
  e.course_id,  c.course_name,
  e.enroll_date
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Course  c ON e.course_id  = c.course_id
ORDER BY e.enroll_date, e.student_id;

SELECT
  r.student_id, s.full_name AS student_name,
  r.course_id,  c.course_name,
  r.mid_score, r.final_score
FROM Result r
JOIN Student s ON r.student_id = s.student_id
JOIN Course  c ON r.course_id  = c.course_id
ORDER BY r.course_id, r.student_id;
