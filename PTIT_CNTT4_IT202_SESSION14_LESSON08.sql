create database social_network;
use social_network;

-- bảng users
create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null
);

-- bảng posts
create table posts (
    post_id int auto_increment primary key,
    user_id int not null,
    content text not null,
    comments_count int default 0,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);

-- bảng comments
create table comments (
    comment_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

-- dữ liệu mẫu
insert into users(username) values
('anh'),
('binh');

insert into posts(user_id, content)
values (1, 'bai viet dau tien');

-- stored procedure đăng bình luận có savepoint
delimiter $$

create procedure sp_post_comment(
    in p_post_id int,
    in p_user_id int,
    in p_content text,
    in p_force_error int
)
begin
    declare v_count int default 0;

    start transaction;

    -- kiểm tra post tồn tại
    select count(*) into v_count
    from posts
    where post_id = p_post_id;

    if v_count = 0 then
        rollback;
        signal sqlstate '45000'
        set message_text = 'post khong ton tai';
    end if;

    -- thêm bình luận
    insert into comments(post_id, user_id, content)
    values (p_post_id, p_user_id, p_content);

    savepoint after_insert;
    -- gây lỗi cố ý để test savepoint
    if p_force_error = 1 then
        rollback to after_insert;
        rollback;
        signal sqlstate '45000'
        set message_text = 'loi khi cap nhat comments_count';
    end if;

    -- cập nhật số lượng comment
    update posts
    set comments_count = comments_count + 1
    where post_id = p_post_id;

    commit;
end$$

delimiter ;

-- test thành công
call sp_post_comment(1, 1, 'comment hop le', 0);

-- test gây lỗi (rollback)
call sp_post_comment(1, 1, 'comment loi', 1);

-- kiểm tra dữ liệu
select * from posts;
select * from comments;
