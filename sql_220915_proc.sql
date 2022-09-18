-- 스토어드 프로시저 만들기 
USE market_db;
DROP PROCEDURE IF EXISTS use_proc;
DELIMITER $$
CREATE PROCEDURE use_proc()
BEGIN
SELECT * FROM member;
END $$
DELIMITER ;

-- 스토어드 프로시저 실행(호출)
CALL use_proc;


-- 입력매개변수 활용
-- 매개변수 한 개 일 때
USE market_db;
DROP PROCEDURE IF EXISTS user_proc1;
DELIMITER $$
CREATE PROCEDURE user_proc1( IN userName VARCHAR(10))
BEGIN
SELECT * FROM member
WHERE mem_name = userName;
END $$

DELIMITER ;

CALL user_proc1('블랙핑크');

-- 매개변수 두 개 일 때
DROP PROCEDURE IF EXISTS user_proc2;
DELIMITER $$
CREATE PROCEDURE user_proc2(
IN userNumber INT,
IN userHeight INT)

BEGIN
SELECT * FROM member
WHERE mem_number > userNumber OR height>userHeight;
END $$
DELIMITER ;

CALL user_proc2(6, 165);

CREATE TABLE IF not exists noTable(
id int auto_increment primary key,
txt char(10) );

delimiter $$
create procedure user_proc3(
in txtValue CHAR(10),
out outValue int)
begin
insert into noTable values(null, txtValue);
select max(id) into outValue from noTable;
end $$
delimiter ;

call user_proc3 ('test', @outValue);
select concat('입력된 id값 ==> ', @outValue);
select * from noTable;

drop procedure if exists ifelse_proc;
delimiter $$
create procedure ifelse_proc( 
in memName varchar(10) )
begin
declare debutYear int;
select year(debut_date) into debutYear from member
where mem_name=memName;
if (debutYear >= 2016) then
select '신인가수' as '메세지';
else 
select '고참가수' as '메세지';

end if;
end $$
delimiter ;

call ifelse_proc('오마이걸');

use market_db;
select * from member where mem_name='오마이걸';

drop procedure if exists while_proc;
delimiter $$
create procedure while_proc()
begin
declare hap int;
declare num int;
set hap = 0;
set num = 0;

while (num<100) do
set num=num+1;
set hap=hap+num;
end while;
select hap as '1~100까지 합';
end $$
delimiter ;
call while_proc();

-- 동적 sql 사용
drop procedure if exists dynamic_proc;
delimiter $$
create procedure dynamic_proc(
in tableName varchar(20))
begin
set @sqlQuery =concat('select * from ',tableName);
prepare myQuery from @sqlQuery;
execute myQuery;
deallocate prepare myQuery;
end $$
delimiter ;
call dynamic_proc('member');
call dynamic_proc('buy');