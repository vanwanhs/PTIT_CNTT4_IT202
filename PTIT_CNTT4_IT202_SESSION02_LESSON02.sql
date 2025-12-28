drop database if exists Session02;
create database Session02;
use Session02;
create table Classes(
	class_id int unsigned auto_increment primary key,
    class_name varchar(50) not null,
    school_year int unsigned not null
);
create table Students(
	id_student int unsigned auto_increment primary key,
    full_name varchar(100) not null,
    birthday date not null,
    class_id int unsigned not null
);
alter table Students add constraint fk_student_class foreign key (class_id) references Classes(class_id)


