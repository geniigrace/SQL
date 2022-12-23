
use sqldb;
create table stdtbl
( stdName varchar(10) not null primary key,
addr char(4) not null);

create table clubtbl
(clubName varchar(10) not null primary key,
roomNo char(4) not null);

create table stdclubtbl
(num int   auto_increment not null primary key,
stdName varchar(10) not null,
clubName  varchar(10) not null,
foreign key(stdName) references stdtbl(stdName),
foreign key(clubName) references clubtbl(clubName)
);

insert into stdtbl values ('김범수','경남'), ('성시경','서울'),('조용필','경기'),('은지원','경북'),('바비킴','서울');

insert into clubtbl values ('수영','101호'), ('바둑','102호'), ('축구','103호'),('봉사','104호');

insert into stdclubtbl values (null, '김범수','바둑'),(null,'김범수','축구'), (null,'조용필','축구'),
(null,'은지원','축구'), (null,'은지원','봉사'),(null,'바비킴','봉사');

select * from stdtbl;
select * from clubtbl;
select * from stdclubtbl;

-- inner join 
select sc.stdName, addr, sc.clubName, roomNo
from stdclubtbl sc
inner join stdtbl s
on sc.stdName = s.stdName
inner join clubtbl c
on sc.clubName = c.clubName
order by sc.stdName asc;

select sc.clubName, roomNo, sc.stdName, addr
from stdclubtbl sc
inner join stdtbl s
on sc.stdName = s.stdName
inner join clubtbl c
on sc.clubName = c.clubName
-- where sc.clubName ='축구'
order by sc.clubName asc;

-- outer join 
select u.userID, u.userName, b.prodName, u.addr, concat(u.mobile1, u.mobile2) '연락처'
from userTBL u -- userTBL : 왼쪽
left outer join buyTBL b -- buyTBL : 오른쪽 // 왼쪽 기준 userTBL 정보는 모두 출력되며 미포함된 오른쪽 테이블에는 null 로 표기 
on u.userID = b.userID
order by u.userID;

select u.userID, u.userName, b.prodName, u.addr, concat(u.mobile1, u.mobile2) '연락처'
from buyTBL b 
left outer join userTBL u
on u.userID = b.userID
order by u.userID;


select u.userID, u.userName, b.prodName, u.addr, concat(u.mobile1, u.mobile2) as '연락처'
from userTBL u
left outer join buyTBL b
on u.userID = b.userID
where b.prodName is null -- null 인 자료만 찾기 
order by u.userID;


select s.stdName, s.addr, sc.clubName, c.roomNo
from stdclubtbl sc
inner join clubtbl c
on sc.clubName = c.clubName
right outer join stdtbl s
on s.stdName = sc.stdName
order by s.stdName asc;

select c.clubName, c.roomNo, s.stdName, s.addr
from stdclubtbl sc
inner join stdtbl s
on sc.stdName = s.stdName
right outer join clubtbl c
on c.clubName = sc.clubName
order by c.clubName asc;

-- Q sol
select c.clubName, c.roomNo, s.stdName, s.addr
from stdtbl s
left outer join stdclubtbl sc
on sc.stdName = s.stdName
right outer join clubtbl c
on sc.clubName = c.clubName
order by c.clubName;

-- 만든 두 테이블 붙이기
select s.stdName, s.addr, sc.clubName, c.roomNo
from stdclubtbl sc
inner join clubtbl c
on sc.clubName = c.clubName
right outer join stdtbl s
on s.stdName = sc.stdName
union -- 테이블 이어쓰기 
select c.clubName, c.roomNo, s.stdName, s.addr
from stdclubtbl sc
inner join stdtbl s
on sc.stdName = s.stdName
right outer join clubtbl c
on c.clubName = sc.clubName;

-- cross join

use sqldb;
select *
from buyTBL
cross join userTBL;

-- self join

use sqldb;
create table empTbl (emp char(3), manager char(3), empTel varchar(8));
insert into empTbl values('나사장',null,'0000');
insert into empTbl values('김재무','나사장','2222');
insert into empTbl values('김부장','김재무','2222-1');
insert into empTbl values('이부장','김재무','2222-2');
insert into empTbl values('우대리','이부장','2222-2-1');
insert into empTbl values('지사원','이부장','2222-2-2');
insert into empTbl values('이영업','나사장','1111');
insert into empTbl values('한과장','이영업','1111-1');
insert into empTbl values('최정보','나사장','3333');
insert into empTbl values('윤차장','최정보','3333-1');
insert into empTbl values('이주임','윤차장','3333-1-1');

select * from empTbl;

select e1.emp as '부하직원', e1.manager as '직속상관', e2.empTel as '직속상관 연락처'
from empTbl e1
inner join empTbl e2
on  e1.manager = e2.emp
where e1.emp='우대리';

-- union

use sqldb;
select stdName, addr from stdtbl
union all
select clubName, roomNo from clubtbl;

select userName, concat(mobile1, mobile2) as '전화번호' from userTBL
where userName not in (select userName from userTBL where mobile1 is null);

select userName, concat(mobile1, mobile2) as '전화번호' from userTBL
where userName in (select userName from userTBL where mobile1 is null);


-- procedure
use sqldb;
drop procedure if exists ifProc;
delimiter $$
create procedure ifProc()
begin
declare var1 int;
set var1 = 100;

if var1 = 100 then
select '100입니다.';
else
select '100이 아닙니다.';
end if;
end $$
delimiter ;
call ifProc();

drop procedure if exists ifProc2;
use employees;
delimiter $$
create procedure ifProc2()
begin
declare hireDate date;
declare curDate date;
declare days int;

select hire_date into hireDATE
from employees.employees
where emp_no=10001;

set curDate = current_date();
set days = datediff(curDate, hireDate);
if(days/365) >= 5 then
select concat('입사한지 ', days,' 일이나 지났습니다.');
else
select '입사한지 '+days+' 일밖에 안되었네요.';
end if;
end $$
delimiter ;

call ifProc2();

drop procedure if exists ifProc3;
use sqldb;
delimiter $$
create procedure ifProc3()
begin
declare point int ;
declare credit char(1);
set point = 77;

if point >= 90 then
set credit = 'A';
elseif point >= 80 then
set credit = 'B';
elseif point >= 70 then
set credit = 'C';
elseif poin >= 60 then
set credit = 'D';
else
set credit = 'F';
end if;
select concat ('취득점수 ==> ', point), concat('학점==> ',credit);
end $$
delimiter ;

call ifProc3();

drop procedure if exists caseProc;
use sqldb;
delimiter $$
create procedure caseProc()
begin
declare point int;
declare credit char(1);
set point = 77;

case 
when point >= 90 then 
set credit = 'A';
when point >= 80 then
set credit = 'B';
when point >= 70 then
set credit = 'C';
when point >= 60 then
set credit = 'D';
else 
set credit = 'F';
end case ;
select concat('취득점수 ==> ', point), concat('학점 ==> ', credit);
end $$
delimiter ;


call caseProc();

use sqldb;
select * from buyTBL;
select * from userTBL;

-- Q
use sqldb;
select u.userID, u.userName, sum(price*amount) as '총구매액', 
case
when (sum(price*amount) >= 1500) then '최우수고객'
when (sum(price*amount) >=1000) then '우수고객'
when (sum(price*amount) >=1 ) then '일반고객'
else '유령고객'
end as '고객등급'
from buyTBL b
right outer join userTBL u
on b.userID = u.userID
group by u.userID, u.userName
order by sum(price*amount) desc ;