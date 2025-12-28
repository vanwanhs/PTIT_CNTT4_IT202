drop database if exists session02;
create database session02;
use session02;
drop table if exists enrollment;
drop table if exists student_03;
drop table if exists subject_03;
create table Student_03(
	id_student int unsigned auto_increment primary key,
    full_name varchar(50) not null
);
create table Subject_03(
	id_subject int unsigned auto_increment primary key,
    name_subject varchar(50) not null,
    credit int unsigned not null,
    id_teacher int unsigned not null
);
 create table Enrollment(
    id_student int unsigned  not null,
    id_subject int unsigned  not null,
    register_date date not null,
	primary key (id_student, id_subject)
 );
create table teacher(
	id_teacher int unsigned auto_increment primary key,
    full_name varchar(50) not null,
    email varchar(50) unique not null
);
create table finalScore(
	id_student int unsigned not null,
    id_subject int unsigned not null,
    primary key (id_student, id_subject),
    continuous_score decimal(4,2),
    final_score decimal(4,2)
);
alter table Subject_03 add constraint CHK_credit check(credit > 0 ); 
alter table Subject_03 add constraint fk_Subject_teacher foreign key (id_teacher) references teacher(id_teacher);
alter table finalScore add constraint fk_finalScore_student foreign key (id_student) references Student_03(id_student);
alter table finalScore add constraint fk_finalScore_subject foreign key (id_subject) references Subject_03(id_subject);
alter table finalScore add constraint CHK_continuous_score check(continuous_score between 0 and 10);
alter table finalScore add constraint CHK_final_score check(final_score between 0 and 10);
alter table enrollment add constraint fk_Enrollment_student foreign key (id_student) references Student_03(id_student);
alter table enrollment add constraint fk_Enrollment_subject foreign key (id_subject) references Subject_03(id_subject);
