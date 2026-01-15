create database social_network;
use social_network;

-- bang users
create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null,
    friends_count int default 0
);

-- bang friend_requests
create table friend_requests (
    request_id int auto_increment primary key,
    from_user_id int not null,
    to_user_id int not null,
    status enum('pending','accepted','rejected') default 'pending',
    foreign key (from_user_id) references users(user_id),
    foreign key (to_user_id) references users(user_id)
);

-- bang friends
create table friends (
    user_id int not null,
    friend_id int not null,
    primary key (user_id, friend_id),
    foreign key (user_id) references users(user_id),
    foreign key (friend_id) references users(user_id)
);

-- du lieu mau
insert into users(username) values
('anh'),
('binh'),
('chi');

insert into friend_requests(from_user_id, to_user_id)
values (1, 2);

-- stored procedure chap nhan loi moi ket ban
delimiter $$

create procedure sp_accept_friend_request(
    in p_request_id int,
    in p_to_user_id int
)
begin
    declare v_from_user int;
    declare v_count int default 0;

    set transaction isolation level repeatable read;
    start transaction;

    -- kiem tra request hop le
    select from_user_id
    into v_from_user
    from friend_requests
    where request_id = p_request_id
      and to_user_id = p_to_user_id
      and status = 'pending';

    if v_from_user is null then
        rollback;
        signal sqlstate '45000'
        set message_text = 'loi request khong hop le';
    end if;

    -- kiem tra da la ban chua
    select count(*) into v_count
    from friends
    where user_id = p_to_user_id
      and friend_id = v_from_user;

    if v_count > 0 then
        rollback;
        signal sqlstate '45000'
        set message_text = 'da la ban truoc do';
    end if;

    -- them ban hai chieu
    insert into friends(user_id, friend_id)
    values (p_to_user_id, v_from_user);

    insert into friends(user_id, friend_id)
    values (v_from_user, p_to_user_id);

    -- cap nhat friends_count
    update users
    set friends_count = friends_count + 1
    where user_id in (p_to_user_id, v_from_user);

    -- cap nhat trang thai request
    update friend_requests
    set status = 'accepted'
    where request_id = p_request_id;

    commit;
end$$

delimiter ;

-- test thanh cong
call sp_accept_friend_request(1, 2);

-- test loi (chap nhan lai)
call sp_accept_friend_request(1, 2);

-- kiem tra ket qua
select * from users;
select * from friends;
select * from friend_requests;
