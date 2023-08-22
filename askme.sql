create database askme;
use askme;
-- =============================== USERS ===============================
create table role(
	id int auto_increment primary key,
    name varchar(50)
);
insert into role (name) values
('admin'),
('user');
create table users(
	id int auto_increment primary key,
    roleId int,
    status bit, -- true: unlock, false: locked
    creationDate datetime default now(),
    fullName varchar(50),
    email varchar(255),
    address text,
    avatar text,
    about text,
    username varchar(20),
    password text -- text để mã hóa
    
);
alter table users add foreign key (roleId) references role(id);
-- =============================== POSTS ===============================
create table postTypes(
    id int auto_increment primary key,
    name varchar(50)
);
insert into postTypes (name) values
('question'),
('answer');
create table posts(
	id int auto_increment primary key,
    postTypeId int,
    userId int,
    userFullName varchar(50),
	createdDate datetime default now(),
    editedDate datetime,
    closedDate datetime,
    title varchar(255),
    body text,
    attachment text,
    tags varchar(255),
    
    score int default 0,
    viewCount int default 0,
    answerCount int default 0,
    commentCount int default 0,
    favoriteCount int default 0,
    voteCount int default 0,
    status tinyint default 0 -- 1: is solved, 2: is closed
);
alter table posts add foreign key (userId) references users(id);
alter table posts add foreign key (postTypeId) references postTypes(id);
-- =============================== comments ===============================
create table comments(
	id int auto_increment primary key,
    postId int,
    userId int,
    userFullName varchar(50),
    body text,
    creationDate datetime default now(),
    score int default 0
    
);
alter table comments add foreign key (postId) references posts(id);
alter table comments add foreign key (userId) references users(id);
-- =============================== TAGS ===============================
create table tags(
	id int auto_increment primary key,
	name varchar(50),
	count int default 0
); 

create table postTags(
	postId int,
	tagId int,
	primary key(postId,tagId)
);
alter table postTags add foreign key (postId) references posts(id);
alter table postTags add foreign key (tagId) references tags(id);
-- =============================== VOTES ===============================
create table voteTypes(
	id int auto_increment primary key,
    name varchar(255)
);
insert into voteTypes (name) values
('isSolved'),
('like'), 
('dislike'), 
('favorite'),
('report'),
('close'),
('reopen');
create table votes(
	id int auto_increment primary key,
    userId int,
    postId int,
    voteTypeId int,
    creationDate datetime default now()
);
alter table votes add foreign key (userId) references users(id);
alter table votes add foreign key (postId) references posts(id);
alter table votes add foreign key (voteTypeId) references voteTypes(id);
-- =============================== NOTIFICAIONS =================
-- create table noticeTypes(
-- 	id int auto_increment primary key,
--     name varchar(255)
-- );
-- insert into noticeTypes (name) values
-- ('new answer'),
-- ('new comment'),
-- ('mentioned'),
-- ('like');
-- create table notifications(
-- 	id int auto_increment primary key,
--     userId int,
-- 	postId int,
--     noticeTypeId int,
--     body varchar(255),
--     creationDate datetime default now()
-- );
-- alter table notifications add foreign key (userId) references users(id);
-- alter table notifications add foreign key (postId) references posts(id);
-- alter table notifications add foreign key (noticeTypeId) references noticeTypes(id);