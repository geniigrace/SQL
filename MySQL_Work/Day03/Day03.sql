use sqldb;

-- select 와 subquery

select * from userTBL where userName = '김경호';

select userID, userName From userTBL where birthYear >= 1970 and height >=182;
select userID, userName From userTBL where birthYear >=1970 or height >= 182;
select userName, height from userTBL where height >=180 and height <= 183;
select userName, height from userTBL where height between 180 and 183;
select userName, addr from userTBL where addr = '경남' or addr = '전남' or addr = '경북';
select userName, addr from userTBL where addr in ('경남','전남','경북');
select userName, height from userTBL where userName like '김%'; -- 김씨 
select userName, height from userTBL where userName like '_종신'; -- 이름이 종신 

select userName, height from userTBL where height > (select hieght from userTBL where userName = '김경호');
-- 김경호보다 큰사람 

select userName, height from userTBL where height >= any(select height from userTBL where addr = '경남'); -- 작은 수 기준 
select userName, height from userTBL where height >= all(select height from userTBL where addr = '경남'); -- 큰 수 기준 

-- order by

select userName, mDate from userTBL order by mDate; -- 기본이 오름차순 

select userName, mDate from userTBL order by mDate DESC; -- 내림차순 

select userName, height from userTBL order by height desc, userName ASC; -- 키로 내림차순 후 동일값은 이름으로 오름차순 


-- 중복제거

select distinct addr from userTBL;

use employees;
select emp_no, hire_date from employees
order by hire_date asc;

use employees;
select emp_no, hire_date from employees order by hire_date asc limit 0, 5; -- limit 5 offset 0과 동일

use sqldb;
create table buyTBL2 (select * from buyTBL);
select * from buyTBL2;

create table buyTBL3 ( select userID, prodName from buyTBL);
select * from buyTBL3;

-- group by

select userID, SUM(amount) from buyTBL group by userID;

-- Q1
select userID '사용자 아이디' , sum(amount) '총 구매 개수' from buyTBL group by userID;

-- Q2

select avg(amount) '평균 구매 개수' from buyTBL;

-- Q3

select userID 'userID', avg(amount) '평균 구매 개수' from buyTBL group by userID;

-- Q4

select userID '사용자 아이디', sum(price*amount) '총 구매액' from buyTBL group by userID;

-- Q5 only full group 에러 
select userName, max(height) 'max(height)' , min(height) 'min(height)' from userTBL;

-- Q6 only full group 에러
select userName 'name' , height 'max(height)', height 'min(height)' from userTBL group by userName;

-- Q7

select userName, height from userTBL 
where height = (select max(height) from userTBL)
or height = (select min(height) from userTBL);

-- Q8 
select count(mobile1) '휴대폰이 있는 사용자' from userTBL;

-- Q9
select userID '사용자', sum(price*amount) '총구매액' 
from buyTBL 
group by userID 
having sum(price*amount)>1000;

/* 
DML : CRUD
Create : insert 데이터 추가
Read : select 데이터 읽기 
Update : update 데이터 수정 
Delete : delete 데이터 삭제
*/

-- rollup

select num, groupName, sum(price*amount) as '비용'
from buyTBL
group by groupName, num
with rollup;

select groupName, sum(price*amount) as '비용'
from buyTBL
group by groupName
with rollup;

-- insert 문

use sqldb;
create table testTBL1 (id int, userName char(3), age int);
insert into testTBL1 values (1,'홍길동',25);
insert into testTBL1(id, userName) values (2,'설현');
insert into testTBL1 (userName, age, id) values('하니',26,3);
select * from testTBL1;

create table testTBL2
(id int auto_increment primary key,
userName char(3),
age int);


insert into tableTBL2 values (null, '지민', 25);
insert into tableTBL2 values (null, '유나', 22);
insert into tableTBL2 values (null, '유경', 21);

select last_insert_id();

alter table testTBL2 auto_increment=100;
insert into testTBL2 values (null, '찬미', 23);
select * from testTBL2;


use sqldb;
create table testTBL3
( id int auto_increment primary key,
userName char(3),
age int);

alter table testTBL3 auto_increment=1000; -- 넘버링 1000번 부터 
set @@auto_increment_increment =3; -- 3씩 증가 
insert into testTBL3 values (null, '나연' , 20);
insert into testTBL3 values (null, '정연',18);
insert into testTBL3 values (null, '모모', 19);
select * from testTBL3;

-- 대용량 추가
create table testTBL4 (id int, Fname varchar(50), Lname varchar(50)); -- 테이블 만들고 
insert into testTBL4 -- 자료 넣기 
select emp_no, first_name, last_name
from employees.employees;

select * from testTBL4;

use sqldb;
create table testTBL5
(select emp_no, first_name, last_name from employees.employees); -- 테이블 만들면서 바로 자료넣기 

-- Update 수정

select * from testTBL4;

update testTBL4
set Lname = '없음'
where Fname ='Kyoichi';

select * from testTBL4 where Fname='Kyoichi';

select * from buyTBL;

update buyTBL
set price = price*1.5;

-- Delete (Drop : 테이블 삭제, Delete / Truncate : 데이터 삭제)

use sqldb;
create table bigTBL1 (select * from employees.employees);
create table bigTBL2 (select * from employees.employees);
create table bigTBL3 (select * from employees.employees);

delete from bigTBL1;
drop table bigTBL2; -- 테이블까지 전체 삭제 
truncate table bigTBL3;

select * from testTBL4 where Fname = 'Aamer';

-- Q1. 5개만 지우기 
delete from testTBL4 where Fname = 'Aamer' limit 5;

-- Q2. 모두 지우기
delete from testTBL4 where Fname = 'Aamer';

use sqldb;
create table memberTBL (select userID, userName, addr from userTBL limit 3);
alter table memberTBL
add constraint pk_memberTLB primary key (userID); -- PK를 지정
select * from memberTBL ;
