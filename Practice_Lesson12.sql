drop database if exists StudentDB;
CREATE DATABASE StudentDB;
USE StudentDB;
-- 1. Bảng Khoa
CREATE TABLE Department (
    DeptID CHAR(5) PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- 2. Bảng SinhVien
CREATE TABLE Student (
    StudentID CHAR(6) PRIMARY KEY,
    FullName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    DeptID CHAR(5),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- 3. Bảng MonHoc
CREATE TABLE Course (
    CourseID CHAR(6) PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

-- 4. Bảng DangKy
CREATE TABLE Enrollment (
    StudentID CHAR(6),
    CourseID CHAR(6),
    Score FLOAT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
INSERT INTO Department VALUES
('IT','Information Technology'),
('BA','Business Administration'),
('ACC','Accounting');

INSERT INTO Student VALUES
('S00001','Nguyen An','Male','2003-05-10','IT'),
('S00002','Tran Binh','Male','2003-06-15','IT'),
('S00003','Le Hoa','Female','2003-08-20','BA'),
('S00004','Pham Minh','Male','2002-12-12','ACC'),
('S00005','Vo Lan','Female','2003-03-01','IT'),
('S00006','Do Hung','Male','2002-11-11','BA'),
('S00007','Nguyen Mai','Female','2003-07-07','ACC'),
('S00008','Tran Phuc','Male','2003-09-09','IT');

INSERT INTO Course VALUES
('C00001','Database Systems',3),
('C00002','C Programming',3),
('C00003','Microeconomics',2),
('C00004','Financial Accounting',3);

INSERT INTO Enrollment VALUES
('S00001','C00001',8.5),
('S00001','C00002',7.0),
('S00002','C00001',6.5),
('S00003','C00003',7.5),
('S00004','C00004',8.0),
('S00005','C00001',9.0),
('S00006','C00003',6.0),
('S00007','C00004',7.0),
('S00008','C00001',5.5),
('S00008','C00002',6.5);


-- câu 1
select * from Student;
create view View_StudentBasic as
select stu.StudentID, stu.FullName , dep.DeptName from Student stu
join Department dep on  dep.DeptID = stu.DeptID ;
select * from View_StudentBasic;

-- câu 2

create index idx_student_fullname ON Student(FullName);


-- Câu 3: 
drop procedure if exists GetStudentsIT;
DELIMITER //
create procedure GetStudentsIT()
begin 
    select s.StudentID, s.FullName, d.DeptName
    from Student s
	join Department d ON s.DeptID = d.DeptID
    where d.DeptName = 'Information Technology';
end //
DELIMITER ;
call GetStudentsIT();

-- câu 4

create or replace view View_StudentCountByDept AS
select d.DeptName, count(*) as TotalStudents
from Student s
join Department d ON s.DeptID = d.DeptID
group by d.DeptName;

-- Câu 4b:
select *
from View_StudentCountByDept
order by TotalStudents desc
limit 1;

select vSCBD.*
from View_StudentCountByDept vSCBD
where vSCBD.TotalStudents = (select MAX(TotalStudents) from View_StudentCountByDept);

-- Câu 5:
drop procedure if exists GetTopScoreStudent;
DELIMITER //
create procedure GetTopScoreStudent(in p_CourseID char(6))
BEGIN
    select e.StudentID, s.FullName, d.DeptName, c.CourseName, e.Score FROM Enrollment e
    join Student s   ON s.StudentID = e.StudentID
    join Department d ON d.DeptID   = s.DeptID
    join Course c    ON c.CourseID  = e.CourseID
    where e.CourseID = p_CourseID
      and e.Score = (
	select MAX(e2.Score)
	from Enrollment e2
          WHERE e2.CourseID = p_CourseID
      );
END //
DELIMITER ;
call GetTopScoreStudent('C00001');

-- bài 6

-- 6a:
create or replace view  View_IT_Enrollment_DB as
select e.StudentID, s.FullName, d.DeptName, e.CourseID, e.Score from Enrollment e
join Student s on s.StudentID = e.StudentID
join Department d on d.DeptID    = s.DeptID
where d.DeptID = 'IT' and e.CourseID = 'C00001'
with check option;
select * from View_IT_Enrollment_DB order by StudentID;


-- 6b:
DELIMITER //
create procedure UpdateScore_IT_DB(in p_StudentID char(6), inout p_NewScore float)
begin
    if p_NewScore > 10 then set p_NewScore = 10;
    end if;
    if not exists (
        select 1
        from View_IT_Enrollment_DB v
        where v.StudentID = p_StudentID
    ) then
       signal sqlstate '45000'
	set message_text = 'Chỉ được cập nhật điểm cho SV khoa IT đã đăng ký C00001 (Database Systems).';
    end if;
    update Enrollment e
    set e.Score = p_NewScore where e.StudentID = p_StudentID
      and e.CourseID  = 'C00001'
      and exists (
          select 1 from View_IT_Enrollment_DB v where v.StudentID = e.StudentID
		and v.CourseID  = e.CourseID
      );
end //
DELIMITER ;

set @newScore = 11.2; 
call UpdateScore_IT_DB('S00005', @newScore);

select @newScore AS FinalScore;
select * from View_IT_Enrollment_DB ORDER BY StudentID;
select * from Enrollment WHERE CourseID = 'C00001' ORDER BY StudentID;





