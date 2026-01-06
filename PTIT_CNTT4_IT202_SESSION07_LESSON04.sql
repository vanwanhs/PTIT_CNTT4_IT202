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
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-01-05', 2500000),
(2, '2024-01-06', 1800000),
(3, '2024-01-07', 3200000),
(1, '2024-01-08', 1500000),
(4, '2024-01-09', 4500000);

select *,
(
select count(*)
from orders o
where o.customer_id = customers.id
)   as total_orders
 from customers
where (
select count(*)
from orders o
where o.customer_id = customers.id
) > 0;
