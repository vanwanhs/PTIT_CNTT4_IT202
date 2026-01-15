create database social_network;
use social_network;

-- 2. tạo bảng users
create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null,
    following_count int default 0,
    followers_count int default 0
);

-- 3. tạo bảng followers
create table followers (
    follower_id int not null,
    followed_id int not null,
    followed_at datetime default current_timestamp,
    primary key (follower_id, followed_id),
    foreign key (follower_id) references users(user_id),
    foreign key (followed_id) references users(user_id)
);

-- 4. bảng ghi log lỗi
create table follow_log (
    log_id int auto_increment primary key,
    follower_id int,
    followed_id int,
    error_message varchar(255),
    created_at datetime default current_timestamp
);

-- 5. dữ liệu mẫu
insert into users (username) values
('anh'),
('binh'),
('chi');

-- 6. stored procedure follow user
delimiter //

create procedure sp_follow_user(
    in p_follower_id int,
    in p_followed_id int
)
begin
    declare v_count int default 0;

    start transaction;

    -- kiểm tra user tồn tại
    select count(*) into v_count
    from users
    where user_id in (p_follower_id, p_followed_id);

    if v_count < 2 then
        insert into follow_log(follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'user khong ton tai');
        rollback;
        leave proc_end;
    end if;

    -- không cho tự follow
    if p_follower_id = p_followed_id then
        insert into follow_log(follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'khong the tu follow');
        rollback;
        leave proc_end;
    end if;

    -- kiểm tra đã follow chưa
    select count(*) into v_count
    from followers
    where follower_id = p_follower_id
      and followed_id = p_followed_id;

    if v_count > 0 then
        insert into follow_log(follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'da follow truoc do');
        rollback;
        leave proc_end;
    end if;

    -- thực hiện follow
    insert into followers(follower_id, followed_id)
    values (p_follower_id, p_followed_id);

    update users
    set following_count = following_count + 1
    where user_id = p_follower_id;

    update users
    set followers_count = followers_count + 1
    where user_id = p_followed_id;

    commit;

    proc_end: begin end;
end //

delimiter ;

-- 7. test
call sp_follow_user(1, 2);
call sp_follow_user(1, 2);
call sp_follow_user(1, 1);
call sp_follow_user(1, 999);

-- 8. kiểm tra dữ liệu
select * from users;
select * from followers;
select * from follow_log;
