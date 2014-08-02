drop table user;
create table user(
userid INTEGER PRIMARY KEY AUTOINCREMENT,
loginname varchar(50),
family varchar(50),
given varchar(50),
company varchar(50),
position varchar(200),
description varchar(1000),
userimage varchar(1000),
type varchar(10));

drop table userthread;
create table userthread(
userid int,
threadid int primary key);

drop table thread;
create table thread(
threadid INTEGER PRIMARY KEY AUTOINCREMENT,
title varchar(300),
content varchar(5000),
threadimage varchar(1000),
link varchar(1000),
score int default 0,
createdate datetime default (datetime('now','localtime')),
cateid int);

drop table userlike;
create table userlike(
seq INTEGER PRIMARY KEY AUTOINCREMENT,
userid int,
threadid int,
UNIQUE (userid, threadid));

drop table followship;
create table followship(
seq INTEGER PRIMARY KEY AUTOINCREMENT,
userid int,
following int,
UNIQUE (userid, following));

drop table category;
create table category(
cateid int primary key,
catename varchar(20),
catetype varchar(20));
