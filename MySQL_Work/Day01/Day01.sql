select memberName, memberAdd from memberTBL;

select * from memberTBL where memberName='지운이'; 

create table `my TestTBL` (id INT);

drop table `my TestTBL`;

select * from productTBL where productName='세탁기';

create table indexTBL (first_name varchar(14), last_name varchar(16), hire_date date);

insert into indexTBL
select first_name, last_name, hire_date
from employees.employees
limit 500;

select * from indexTBL;

select * from indexTBL where first_name='Mary';

create index idx_indexTBL_firstname ON indexTBL(first_name);

create view uv_memberTBL
AS
select memberName, memberAdd from memberTBL;

select * from uv_memberTBL;

delimiter //
create procedure myProc1()
begin
select * from memberTBL where memberName = '당탕이';
select * from productTBL where productName ='냉장고';
end //
delimiter ;

call myProc1();