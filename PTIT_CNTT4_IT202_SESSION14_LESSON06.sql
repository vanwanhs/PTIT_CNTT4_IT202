create database social_network;
use social_network;
create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null
);
create table posts (
    post_id int auto_increment primary key,
    user_id int not null,
    content text not null,
    likes_count int default 0,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);
create table likes (
    like_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    unique key unique_like (post_id, user_id),
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);
insert into users(username)
values ('anh');

insert into posts(user_id, content)
values (1, 'bai viet duoc like');
start transaction;

insert into likes(post_id, user_id)
values (1, 1);

update posts
set likes_count = likes_count + 1
where post_id = 1;

commit;
start transaction;

insert into likes(post_id, user_id)
values (1, 1);

update posts
set likes_count = likes_count + 1
where post_id = 1;

rollback;
select * from likes;
select post_id, likes_count from posts;
