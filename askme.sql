create database askme;
use askme;
-- =============================== USERS ===============================
create table role(
	id int primary key,
    name varchar(50)
);
create table users(
	id int auto_increment primary key,
    creationDate datetime default now(),
    firstName varchar(50),
    lastName varchar(50),
    email varchar(255),
    address text,
    avatar text,
    about text,
    username varchar(20),
    password varchar(20),
    roleId int,
    status bit -- true: unlock, false: locked
);
alter table users add foreign key (roleId) references role(id);
-- =============================== QUESTIONS ===============================
create table quests(
	id int auto_increment primary key,
    userId int,
	createdDate datetime default now(),
    editedDate datetime,
    closedDate datetime,
    title varchar(255),
    body text,
    attachment text,
    tags varchar(255),
    
    viewCount int default 0,
    answerCount int default 0,
    favoriteCount int default 0,
    voteCount int default 0,
    status tinyint default 0 -- 1: is solved, 2: is closed
);
alter table quests add foreign key (userId) references users(id);
-- =============================== ANSWERS ===============================
create table answers(
	id int auto_increment primary key,
    userId int,
    questId int,
    body text,
    creationDate datetime default now(),
	editedDate datetime,
    
    bestStatus bit,
	voteCount int default 0,
    status tinyint default 0 -- 1: best answer
);
alter table answers add foreign key (questId) references quests(id);
alter table answers add foreign key (userId) references users(id);
-- =============================== TAGS ===============================
create table tags(
	id int auto_increment primary key,
	name varchar(50),
	count int default 0
); 
-- 1 quest có nhiều tags
create table questTags(
	questId int,
	tagId int,
	primary key(questId,tagId)
);
alter table questTags add foreign key (questId) references quests(id);
alter table questTags add foreign key (tagId) references tags(id);
-- =============================== VOTES ===============================
create table voteTypes(
	id int auto_increment primary key,
    name varchar(255)
);
insert into voteTypes (name) values
('upVote'),
('downVote');
create table votes(
	id int auto_increment primary key,
    userId int,
    postId int,
    voteTypeId int
);
alter table votes add foreign key (userId) references users(id);
alter table votes add foreign key (postId) references quests(id);
alter table votes add foreign key (postId) references answers(id);
alter table votes add foreign key (voteTypeId) references voteTypes(id);
-- =============================== COMMENT =================
create table comments(
	id int auto_increment primary key,
    userId int,
    postId int,
    body text,
    parentCommentId int -- 1 comment có thể có nhiều replies
);
alter table comments add foreign key (userId) references users(id);
alter table comments add foreign key (postId) references quests(id);
alter table comments add foreign key (postId) references answers(id);
alter table comments add foreign key (parentCommentId) references comments(id);
-- =============================== NOTIFICAIONS =================
create table notificationTypes(
	id int auto_increment primary key,
    name varchar(255)
);
insert into notificationTypes (name) values
('newAnswer'),
('newComment'),
('mention'),
('vote');
create table notifications(
	id int auto_increment primary key,
    userId int,
	postId int,
    notificationTypeId int
);
alter table notifications add foreign key (userId) references users(id);
alter table notifications add foreign key (postId) references quests(id);
alter table notifications add foreign key (postId) references answers(id);
alter table notifications add foreign key (notificationTypeId) references notificationTypes(id);