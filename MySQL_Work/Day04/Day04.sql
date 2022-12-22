
use sqldb;

with abc(userid, total) -- userid : userid, total : sum(price*amount)
as
(select userid, sum(price*amount)
from buyTBL group by userid )

select *from abc order by total desc;

with cte_userTBL(addr, maxHeight)
as
(select addr, max(height) from userTBL group by addr)
select avg(maxHeight*1.0) as '각 지역별 최고키의 평균' from cte_userTBL;

-- cast : 형변환 
select cast('2020-10-19 12:35:29.123' as date) as 'date';
select cast( '2020-10-19 12:35:29.123' as time)as 'time';
select cast('2020-10-19 12:35:29.123' as datetime) as 'datetime';

-- 변수사용
use sqldb;
set @myVar1 = 5;
set @myVar2 =3;
set @myVar3 = 4.25;
set @myVar4='가수이름 ==>' ;

select @myVar1;
select @myVar2 + @myVar3;

select @myVar4, userName, height from userTBL where height>180;

set @myVar1 = 3 ;
prepare myQuery
from 'select userName, height from userTBL order by height limit ?';
execute myQuery using @myVar1;


use sqldb;
select avg(amount) as '평균구매개수' from buyTBL;

select cast( avg(amount) as signed integer) as '평균 구매 개수' from buyTBL;
select convert(avg(amount), signed integer ) as '평균 구매 개수 ' from buyTBL;

select cast('2020$12$12' as date);
select cast('2020/12/12' as date);
select cast('2020@12@12' as date);

select num, concat(cast(price as char(10)), ' x ', cast(amount as char(4)), ' = ') '단가 X 수량' , price*amount as '구매액' from buyTBL;

select '100' + '200'; -- 300 : 정수로 변환되어 연산 
select concat('100','200'); -- 100200 : 문자로 인식하여 문자로 처리 
select concat(100,'200'); -- 100200 : 정수를 문자로 인식하여 문자로 처리 


select 1 > '2mega'; -- 정수 2로 변화되어 비교
select 3 > '2MEGA'; -- 정수 2로 변환되어 비교
select 0 = 'mega2'; -- 문자는 0으로 변환되어 비교

select if (100>200, '참이다','거짓이다');

select ifnull(null, '널이군요'), ifnull(100, '널이군요');

select nullif(100,100), ifnull(200,100);

select case 10
when 1 then 'one'
when 2 then 'two'
when 10 then 'ten'
else 'no'
end as 'case practice';

select ascii('A'), char(65);

select bit_length('abc'), -- 한문자당 1바이트, 8비트
char_length('abc'), 
length('abc');

select bit_length('가나다'), -- 한글자당 3바이트, 24비트
char_length('가나다'), 
length('가나다');

select concat_ws('/','2025','01','01');

select elt(2,'하나','둘','셋'), -- 2번째 선택
field('둘','하나','둘','셋'),  -- '둘'이라는 글자가 몇번째 인덱스에 있는지 
find_in_set('둘','하나,둘,셋'), -- '둘'이라는 글자가 몇번째 인덱스에 있는지 
instr('하나둘셋','둘'), -- '둘'이라는 글자가 몇번째에 있는지 
locate('둘','하나둘셋'); -- '둘'이라는 글자가 몇번째에 있는지 

select format(123454.11231223,4); -- 소숫점 4짜리까지 표현

select bin(31), hex(31), oct(31);

select insert('asdhgfhf',3,4,'@@@@'), insert('asdhgfhf',3,2,'@@@@');
select left('asdfer',3), right('asdfewqt',3);
select lower('asdfEFG'), upper('qwerDSEF');
select lpad('이것이',5,'##'), rpad('이것이',5,'##');
select ltrim('		이것이'), rtrim('이것이 	');
select trim('	이것이	'), trim(both 'ㅋ' from 'zzz재밌어요 ㅋㅋㅋ');
select repeat('이것이',3);
select replace ('이것이 mysql 이다','이것이','this is');

select reverse('MySQL');

select concat('이것이', space(10), 'MySQL이다');
select substring('대한민국만세',3,2);
select substring_index('cafe.naver.com','.',2), substring_index('cafe.naver.com','.',-2);
select abs(-100);

select ceiling(4.3),  -- 올림
floor(4.7), -- 내림 
round(4.7); -- 반올림 

select conv('AA',16,2), -- 진법변환 : 16진수를 2진수로 
conv(100,10,8); -- 진법번환 : 10진수를 8진수로

select degrees(pi()), -- pi의 각도를 확인해줘 
radians(180); -- 라디안값을 알려줘

select mod(157, 10), 157%10, 157 mod 10; -- 나머지값구하기 

select pow(2,3), -- 제곱  
sqrt(9); -- 제곱수 

select rand(), 
floor(1+(rand()*(6-1)) );

select sign(100), -- 양수 일때 1 
sign(0), -- 0일때 0 
sign(-100.123); -- 음수일때 -1 

select truncate(12345.12345,2), -- 소수점 2자리까지 
truncate(12345.12345, -2); -- 소수점으로부터 2자리 위로 올려서 버림 

select adddate('2025-01-01', interval 31 day), adddate('2025-01-01', interval 1 month);
select subdate('2025-01-01', interval 31 day), subdate('2025-01-01', interval 1 month);

select addtime('2025-01-01 23:59:59', '1:1:1'), addtime('15:00:00','2:10:10');
select subtime('2025-01-01 23:59:59', '1:1:1'), subtime('15:00:00','2:10:10');

select year(curdate()), month(curdate()), dayofmonth(curdate());
select hour(curtime()), minute(current_time()), second(current_time()), microsecond(current_time());

select date(now()), time(now());
select datediff('2025-01-01',now()), timediff('23:23:59', '12:11:10'); -- 기준날짜와의 차이, 각 시간의 차이 
select dayofweek(curdate()), monthname(curdate()), dayofyear(curdate()); -- 주 차, 월, 일 차 
select last_day('2025-02-01');
select makedate(2025,32);
select maketime(12,11,10);
select period_add(202501,11), period_diff(202501, 202312);

select quarter('2025-07-07');
select time_to_sec('12:11:10');
select current_user(), database();


use sqldb;
update buyTBL set price=price*2;
select row_count();
select sleep(5);
select '5초후에 보여요';

-- 피벗 

use sqldb;
create table pivotTest
( uName char(3),
season char(2),
amount int);

insert into pivotTest values
('김범수','겨울',10), ('윤종신','여름',15), ('김범수','가을',25),
('김범수','봄',3), ('김범수','봄',37), ('윤종신','겨울',40),
('김범수','여름',14), ('김범수','겨울',22),('윤종신','여름',64);

select * from pivotTest;

select uName, 
sum(if(season = '봄', amount, 0)) as '봄', 
sum(if(season='여름', amount, 0)) as '여름',
sum(if(season='가을', amount, 0)) as '가을',
sum(if(season='겨울', amount, 0)) as '겨울',

sum(amount) as '합계'
from pivotTest group by uName;

select season, sum(if(uName='김범수', amount, 0)) '김범수',
sum(if(uName='윤종신', amount, 0)) '윤종신',
sum(amount) '합계' from pivotTest group by season;



-- json
use sqldb;
select json_object('name',userName,'height',height) as 'json 값'
from userTBL
where height>=180;

set @json='{"userTBL" :
[
{"name":"임재범","height":182},
{"name":"이승기","height":182},
{"name":"성시경","height":186}
]
}';

select json_valid(@json) as json_valid; -- 값이 있는지 
select json_search(@json, 'one', '성시경') as json_search; 
select json_extract(@json, '$.userTBL[2].name') as json_extract;
select json_insert(@json, '$.userTBL[0].mDate','2009-09-09') as json_insert;
select json_replace(@json, '$.userTBL[0].name', '홍길동') as json_replace;
select json_remove(@json, '$.userTBL[0]') as json_remove;


-- inner join

use sqldb;
select *
from buyTBL 
inner join userTBL 
on buyTBL.userID=userTBL.userID
where buyTBL.userID = 'JYP';

select *
from buyTBL
inner join userTBL
on buyTBL.userID = userTBL.userID
order by num;

-- Q
select b.userID, userName, prodName, addr, mobile2
from buyTBL b
inner join userTBL u
on b.userID = u.userID
order by num;

-- 위 문제를 Join 없이 쓰기
select buyTBL.userID, userName, prodName, addr, mobile2
from buyTBL, userTBL
where buyTBL.userID = userTBL.userID
order by num;