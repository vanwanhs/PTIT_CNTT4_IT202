create database social_network;
use social_network;

create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null,
    posts_count int default 0
);

create table posts (
    post_id int auto_increment primary key,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);
insert into users(username)
values ('anh');
start transaction;

insert into posts(user_id, content)
values (1, 'bai viet dau tien');

update users
set posts_count = posts_count + 1
where user_id = 1;

commit;
start transaction;

insert into posts(user_id, content)
values (999, 'bai viet loi');

update users
set posts_count = posts_count + 1
where user_id = 999;

rollback;
