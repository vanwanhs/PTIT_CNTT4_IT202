drop database if exists session07;
create database session07;
use session07;
create table products (
    id int auto_increment primary key,
    name varchar(55) not null,
    price decimal(10,2) not null
);
create table order_items (
    order_id int,
    product_id int,
    quantity int not null,
    foreign key (product_id) references products(id)
);
insert into products (id, name, price) values
(1, 'chuot logitech', 350000),
(2, 'ban phim co', 1200000),
(3, 'tai nghe gaming', 850000),
(4, 'man hinh 24 inch', 3200000),
(5, 'usb 64gb', 180000),
(6, 'o cung ssd 512gb', 1500000),
(8, 'webcam full hd', 900000);
insert into order_items (order_id, product_id, quantity) values
(1, 1, 2),
(1, 3, 1),
(2, 2, 1),
(2, 5, 3),
(3, 4, 1),
(3, 6, 2),
(3, 1, 1);

select * from Products
where id in ( select product_id from order_items)