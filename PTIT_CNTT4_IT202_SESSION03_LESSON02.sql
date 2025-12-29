-- drop database if exists Session03;
create database Session03;
use Session03;
create table Student (
	student_id char(10) not null primary key,
    full_name varchar(50) not null,
    date_of_birthday date,
    email varchar(50) unique
);

-- thêm dữ liệu liệu danh sách học sinh;
insert into Student values 
('1234567890','Phạm Thị Hồng Nhung','2006-12-13','pthongnhung13122006@gmail.com'),
('1234567891','Phạm Thị Hồng Nhung','2006-12-13','pthongnhung13122005@gmail.com'),
('1234567892','Phạm Thị Hồng Nhung','2006-12-13','pthongnhung13122004@gmail.com')


