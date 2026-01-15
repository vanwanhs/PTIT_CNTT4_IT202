
create database social_network;
use social_network;

-- bang users
create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null,
    posts_count int default 0
);

-- bang posts
create table posts (
    post_id int auto_increment primary key,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);

-- bang likes
create table likes (
    like_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

-- bang comments
create table comments (
    comment_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

-- bang log xoa bai viet
create table delete_log (
    log_id int auto_increment primary key,
    post_id int,
    deleted_by int,
    deleted_at datetime default current_timestamp
);

-- du lieu mau
insert into users(username, posts_count) values
('anh', 1),
('binh', 0);

insert into posts(user_id, content)
values (1, 'bai viet can xoa');

insert into likes(post_id, user_id)
values (1, 2);

insert into comments(post_id, user_id, content)
values (1, 2, 'comment thu');

-- stored procedure xoa bai viet
delimiter $$

create procedure sp_delete_post(
    in p_post_id int,
    in p_user_id int
)
begin
    declare v_count int default 0;

    start transaction;

    -- kiem tra bai viet ton tai va dung chu so huu
    select count(*) into v_count
    from posts
    where post_id = p_post_id
      and user_id = p_user_id;

    if v_count = 0 then
        rollback;
        signal sqlstate '45000'
        set message_text = 'khong du quyen xoa hoac bai viet khong ton tai';
    end if;

    -- xoa like
    delete from likes
    where post_id = p_post_id;

    -- xoa comment
    delete from comments
    where post_id = p_post_id;

    -- xoa bai viet
    delete from posts
    where post_id = p_post_id;

    -- giam so bai viet cua user
    update users
    set posts_count = posts_count - 1
    where user_id = p_user_id;

    -- ghi log xoa
    insert into delete_log(post_id, deleted_by)
    values (p_post_id, p_user_id);

    commit;
end$$

delimiter ;

-- test thanh cong
call sp_delete_post(1, 1);

-- test khong hop le (khong phai chu bai viet)
call sp_delete_post(1, 2);

-- kiem tra ket qua
select * from users;
select * from posts;
select * from likes;
select * from comments;
select * from delete_log;
