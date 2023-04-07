-- 스토어드 함수 및 커서 실습

use market_db;

drop procedure if exists cursor_proc;
delimiter $$
create procedure cursor_proc()
begin
declare memNumber int default 0;
declare cnt int default 0; -- 초기값을 0으로 설정
declare totNumber int default 0;
declare endOfRow boolean default false; 
		-- 행의 끝을 파악하기 위한 변수 선언, 초기에는 행의끝이 아니니 false 로 초기화

declare memberCursor cursor for
select mem_number from member;

declare continue handler -- 반복조건을 준비하는 예약어
for not found set endOfRow = true; -- 더이상 행이 없을 때 endOfRow를 true로 세팅 

open memberCursor;
cursor_loop : Loop
fetch memberCursor into memNumber;
if endOfRow THEN
leave cursor_loop;
end if;
set cnt=cnt+1;
set totNumber=totNumber+memNumber;
end loop cursor_loop;
select (totNumber/cnt) as '회원 평균 인원수';
close memberCursor;
end $$
delimiter ;
call cursor_proc();
