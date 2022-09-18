-- procedure function

-- 함수권한
set global log_bin_trust_function_creators=1;

use market_db;
drop function if exists sumFunc;
delimiter $$
create function sumFunc(num1 int, num2 int)
returns int
begin 
return num1+num2;
end $$
delimiter ;

select sumFunc(100,200);


-- 데뷔년도 입력하면 활동기간 표시
drop function if exists calYearFunc;
delimiter $$
create function calYearFunc(dYear int)
returns int
begin
declare runYear int;
set runYear = year(curdate())-dYear;
return runYear;
end $$
delimiter ;

select calYearFunc(2010) AS '활동기간';
