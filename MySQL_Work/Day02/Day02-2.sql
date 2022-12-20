insert into memberTBL values ('Figure', '연아','경기도 군포시 당정동');
select * from memberTBL;

update memberTBL set memberAdd = '서울 강남구 역삼동' where memberName='연아';

create table deleteMemberTBL(
memberID char(8),
memberName char(5),
memberAdd char(20),
deletedDate date
);

delimiter //
create trigger trg_deleteMemberTBL
after delete -- 삭제 후에 작동
on memberTBL
for each row -- 각 행마다 적용 
begin
insert into deleteMemberTBL
values (OLD.memberID, OLD.memberName, OLD.memberAdd, curdate()); -- curdate : 현시간 
end //
delimiter ;

delete from memberTBL where memberName = '당탕';

select * from deleteMemberTBL;

drop trigger if exists trg_deletedMemberTBL;

delete from productTBL;

select * from productTBL;

use employees; -- 스키마 선택 
select * from employees; -- 테이블 조회

use shopdb;
select * from memberTBL;
create table test (id int);
insert into test values(1);

select * from test;

use employees;
select * from employees;
