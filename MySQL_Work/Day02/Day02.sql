-- 쿼리문을 사용하여 사용자 만들기
create user director@'%' identified by 'director';
grant all on *.* to director@'%' with grant option; -- 전체권한을 줌 

create user ceo@'%' identified by 'ceo';
grant select on *.* to ceo@'%'; -- select 권한을 줌 


-- select

select * from employees.titles; -- * : 전체속성 출력

select first_name from employees;

select first_name, last_name, gender from employees;

-- show

show databases;

use employees;

show table status;

show tables;

describe employees;

select first_name as 이름, gender 성별, hire_date '회사 입사일' from employees;

-- DB 의 기본

drop database if exists sqldb;
create database sqldb;
use sqldb;
create table userTBL
( userID char(8) not null primary key,
userName varchar(10) not null,
birthYear int not null,
addr char(2) not null,
mobile1 char(3),
mobile2 char(8),
height smallint,
mDate date
);


create table buyTBL
( num int auto_increment not null primary key,
userID char(8) not null,
prodName char(6) not null,
groupName char(4), 
price int not null,
amount smallint not null,
foreign key (userID) references userTBL(userID));


insert into userTBL values('LSG','이승기','1987','서울','011','11111111','182','2008-08-08');
insert into userTBL values('KBS','김범수','1979','경남','011','22222222','173','2012-04-04');
insert into userTBL values('KKJ','김경호','1971','전남','019','33333333','177','2007-07-07');
insert into userTBL values('JYP','조용필','1950','경기','011','44444444','166','2009-04-04');
insert into userTBL values('SSK','성시경','1979','서울',null,null,'186','2013-12-12');
insert into userTBL values('LJB','임재범','1963','서울','016','66666666','182','2009-09-09');
insert into userTBL values('YJS','윤종신','1969','경남',null,null,170,'2005-05-05');
insert into userTBL values('EJW','은지원',1972,'경북','011','88888888',174,'2014-03-03');
insert into userTBL values('JKW','조관우',1965,'경기','018','99999999',172,'2010-10-10');
insert into userTBL values('BBK','바비킴',1973,'서울','010','00000000',176,'2013-05-05');

insert into buyTBL values(null,'KBS','운동화',null,30,2);
insert into buyTBL values(null,'KBS','노트북','전자',1000,1);
insert into buyTBL values(null,'JYP','모니터','전자',200,1);
insert into buyTBL values(null,'BBK','모니터','전자',200,5);
insert into buyTBL values(null,'KBS','청바지','의류',50,3);
insert into buyTBL values(null,'BBK','메모리','전자',80,10);
insert into buyTBL values(null,'SSK','책','서적',15,5);
insert into buyTBL values(null,'EJW','책','서적',15,5);
insert into buyTBL values(null,'EJW','청바지','의류',50,1);
insert into buyTBL values(null,'BBK','운동화',null,30,2);
insert into buyTBL values(null,'EJW','책','서적',15,1);
insert into buyTBL values(null,'BBK','운동화',null,30,2);

select * from userTBL;
select * from buyTBL;

