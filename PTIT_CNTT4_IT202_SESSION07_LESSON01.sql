drop database if exists session07;
create database session07;
use session07;
create table customers (
    id int auto_increment primary key,
    name varchar(100) not null,
    email varchar(100) unique not null
);

create table orders (
    id int auto_increment primary key,
    customer_id int not null,
    order_date date not null,
    total_amount decimal(12,2) not null,
    foreign key (customer_id) references customers(id)
);
insert into customers (id, name, email) values
(1, 'Nguyễn Văn A', 'a@gmail.com'),
(2, 'Trần Thị B', 'b@gmail.com'),
(3, 'Lê Văn C', 'c@gmail.com'),
(4, 'Phạm Thị D', 'd@gmail.com'),
(5, 'Hoàng Văn E', 'e@gmail.com'),
(6, 'Vũ Thị F', 'f@gmail.com'),
(7, 'Đặng Văn G', 'g@gmail.com');
insert into orders (id, customer_id, order_date, total_amount) values
(1, 1, '2024-01-10', 1500000),
(2, 1, '2024-02-05', 2300000),
(3, 2, '2024-02-20', 1200000),
(4, 3, '2024-03-01', 5400000),
(5, 4, '2024-03-15', 800000),
(6, 6, '2024-04-02', 3100000),
(7, 6, '2024-04-18', 950000);
select 	* from customers 
where id in ( select customer_id from orders)
