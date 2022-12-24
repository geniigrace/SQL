
select u.userId, u.userName, sum(price*amount) as '총구매액',
if(sum(price*amount)>=1500, '최우수고객',
if(sum(price*amount)>=1000, '우수고객',
if(sum(price*amount)>=1,'일반고객','유령고객'))) as '고객등급'
from buyTBL b
right outer join userTBL u
on b.userID = u.userID
group by u.userID, u.userName
order by sum(price*amount) desc;


drop procedure if exists whileProc;
delimiter $$
create procedure whileProc()
begin
declare i int;
declare hap int;
set i=1;
set hap=0;

while(i<=100) do
set hap=hap+i;
set i=i+1;
end while;

select hap;
end $$
delimiter ;

call whileProc();


drop procedure if exists whileProc2;
delimiter $$
create procedure whileProc2()
begin
declare i int;
declare hap int;
set i=1;
set hap=0;

myWhile : while (i<=100) do -- while 문에 label 지정
if(i%7=0) then
set i=i+1;
iterate myWhile; -- 지정한 label 문으로 가서 계속 진행 
end if;
set hap = hap+i;
if(hap>1000) then
leave myWhile;
end if;
set i= i+1;
end while;

select hap;
end $$
delimiter ;

call whileProc2();


drop database if exists shopdb;
drop database if exists modelDB;
drop database if exists sqldb;
drop database if exists tabledb;

create database tabledb;
use tabledb;
drop table if exists buyTBL, userTBL;
create table userTBL
( userID char(8) not null primary key,
userName varchar(10) not null,
birthYear int not null,
addr char(2) not null,
mobile1 char(3) null,
mobile2 char(8) null,
height smallint null,
mDate date null
);

create table buyTBL
( num int auto_increment not null primary key,
userID char(8) not null,
prodName char(6) not null,
groupName char(4) null,
price int not null,
amount smallint not null,
foreign key(userID) references userTBL(userID)
);

insert into userTBL values ('LSG','이승기',1987,'서울','011','11111111',182,'2008-08-08');
insert into userTBL values ('KBS','김범수',1979,'경남','011','22222222',173,'2012-04-04');
insert into userTBL values ('KKH','김경호',1971,'전남','019','33333333',177,'2007-07-07');

insert into buyTBL values (null, 'KBS','운동화',null,30,2);
insert into buyTBL values (null, 'KBS','노트북','전자',1000,1);
insert into buyTBL values (null, 'JYP','모니터','전자',200,1);

select * from userTBL;
select * from buyTBL;

drop table if exists buyTBL, userTBL;

create database tabledb;
use tabledb;
drop table if exists buyTBL, userTBL;

create table userTBL
( userID char(8) not null,
userName varchar(10) not null,
birthYear int not null,
constraint primary key PK_userTBL_userID(userID) -- 기본키 설정하는 방법
);

drop table if exists userTBL;
create table userTBL
( userID char(8) not null,
userName varchar(10) not null,
birthYear int not null
);


-- alter : 수정(추가/삭제/수정) 
-- alter add/drop/alter 

alter table userTBL
add constraint PK_userTBL_userID -- 제약조건을 추가할건데 
primary key (userID);  -- 기본키 추가할거야 


-- 외래키 추가해보기

drop table if exists buyTBL;
create table buyTBL
( num int auto_increment not null primary key,
userID char(8) not null,
prodName char(6) not null,
groupName char(4) null,
constraint FK_userTBL_buyTBL foreign key(userID) references userTBL(userID)
);

drop table if exists buyTBL;
create table buyTBL
( num int auto_increment not null primary key,
userID char(8) not null,
prodName char(6) not null,
groupName char(4) null
);

alter table buyTBL
add constraint FK_userTBL_buyTBL
foreign key (userID)
references userTBL(userID);

 use tabledb;
drop table if exists buyTBL, userTBL;
create table userTBL
( userID char(8) not null primary key,
userName varchar(10) not null,
birthYear int not null,
email char(30) null unique
);

use tabledb;
drop table if exists buyTBL, userTBL;
create table userTBL
( userID char(8) not null primary key,
userName varchar(10) not null,
birthYear int not null,
email char(30) null,
constraint AK_email unique (email)
);

-- check
drop table if exists userTBL;
create table userTBL
( userID char(8) primary key,
userName varchar(10),
birthYear int check (birthYear>=1900 and birthYear <= 2023),
mobile1 char(3) null,
constraint CK_name check (userName is not null) -- userName은 not null 
);

alter table userTBL
add constraint CK_mobile1
check (mobile1 in('010','011','016','017','018','019'));

-- default
drop table if exists userTBL;
create table userTBL
( userID char(8) not null primary key,
userName varchar(10) not null,
birthYear int null default -1, -- 입력하지 않은경우 -1 로 입력됨
height smallint null default 170
);

alter table userTBL
alter column birthYear set default -1;

alter table userTBL
alter column height set default 170;

use tabledb;
alter table userTBL
add homepage varchar(30)
default 'http://www.hanbit.co.kr'
null;

alter table userTBL
drop column mobile1;

alter table userTBL
change column userName uName varchar(20) null;

alter table userTBL
drop primary key;

drop table if exists buyTBL, userTBL;
create table userTBL
( userID char(8),
userName varchar(10),
birthYear int,
addr char(2),
mobile1 char(3),
mobile2 char(8),
height smallint,
mDate date);

create table buyTBL
(
num int auto_increment primary key,
userID char(8),
prodName char(6),
groupName char(4),
price int,
amount smallint
);

describe userTBL;
describe buyTBL;

alter table userTBL
add constraint PK_userTBL_userID
primary key (userID);

alter table buyTBL
add constraint FK_userTBL_buyTBL
foreign key (userID)
references userTBL (userID)
on update cascade -- userID가 수정되면 자동으로 buytbl에 있는 외래키 값이 바뀜 
on delete cascade; -- userID 가 삭제되면 자동으로 buytbl에 있는 외래키 값이 바뀜  


-- 뷰 

drop database if exists sqldb;
create database sqldb;
use sqldb;
create table userTBL
(
userID char(8) not null primary key,
userName varchar(10) not null,
birthYear int not null,
addr char(2) not null,
mobile1 char(3),
mobile2 char(8),
height smallint,
mDate date);

CREATE TABLE buytbl -- 회원 구매 테이블(Buy Table의 약자)
(  num       INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID     CHAR(8) NOT NULL, -- 아이디(FK)
   prodName    CHAR(6) NOT NULL, --  물품명
   groupName    CHAR(4)  , -- 분류
   price        INT  NOT NULL, -- 단가
   amount       SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (userID) REFERENCES usertbl(userID)
);

INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);

select * from buyTBL;

use sqldb;
create view v_userbuyTBL
as
select u.userID, u.userName, b.prodName, u.addr, concat(u.mobile1, u.mobile2) as 'mobile'
from userTBL u
inner join buyTBL b
on u.userID = b.userID;

select * from v_userbuyTBL;


select `userID`, `userName` from v_userbuyTBL;

alter view v_userbuyTBL
as
select u.userID, u.userName, b.prodName, u.addr, concat(u.mobile1, u.mobile2) as 'mobile'
from userTBL u
inner join buyTBL b
on u.userID= b.userID;

insert into v_userTBL(userID, userName, addr) values('KBM','김병만','충북');
-- notnull 값이 없어서 추가 안됨

-- 우선순위

drop database if exists sqldb;
create database sqldb;
use sqldb;
create table tbl1
(
a int primary key,
b int,
c int);

show index from tbl1;
create table tbl2
(
a int primary key,
b int unique,
c int unique,
d int
);

show index from tbl2;

create table tbl3
(
a int unique,
b int unique,
c int unique,
d int
);

show index from tbl3;

create table tbl4
(
a int unique not null,
b int unique,
c int unique,
d int
);

show index from tbl4;

create table tbl5
(
a int unique not null,
b int unique,
c int unique,
d int primary key
);
show index from tbl5;


-- index 
create database if not exists testdb;
use testdb;
drop table if exists userTBL;
create table userTBL
( userID char(8) not null primary key,
userNamei varchar(10) not null,
birthYear int not null,
addr nchar(2) not null
);

insert into userTBL values('LSG','이승기',1987,'서울');
Insert into userTBL values('KBS','김범수',1979,'경남');
insert into userTBL values('KKH','김경호',1971,'전남');
insert into userTBL values('JYP','조용필',1950,'경기');
insert into userTBL values('SSK','성시경',1979,'서울');

select * from userTBL;

use testdb;
show index from userTBL;

show table status like 'userTBL';
create index idx_userTBL_addr
on userTBL(addr);

show index from userTBL;

show table status like 'userTBL';

analyze table userTBL; -- 테이블 분석
show table status like 'userTBL';

create unique index idx_userTBL_birthYear
on userTBL (birthYear);

create unique index idx_userTBL_name
on userTBL (userName);
show index from userTBL;

use sqldb;
select * from userTBL where userName ='이승기';