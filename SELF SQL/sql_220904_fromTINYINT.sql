USE market_db;
CREATE TABLE hongong4(
  tinyint_col TINYINT, -- -128 ~ 127
  smallint_col SMALLINT, -- 
  int_col INT,
  bigint_col BIGINT);
INSERT INTO hongong4 VALUES(127, 32767, 2147483647, 9000000000000000000);

-- 변수의 사용
USE market_db;
SET @myVar1=5; -- 변수에 값 지정 
SET @myVar2=4.25; -- 변수에 값 지정 

SELECT @myVar1; -- 변수 출력 
SELECT @myVar1+@myVar2; -- 변수 출력 

SET @txt='가수이름==> ';
SET @height = 166;

SELECT @txt;
SELECT * FROM member;
SELECT @tet, mem_name FROM member WHERE height>@height; 

USE market_db;
SET @count=3; 
PREPARE mySQL FROM 'SELECT mem_name, height FROM member ORDER BY height LIMIT ?'; -- LIMIT 문에는 변수 사용불가하여 PREPARE~EXECUTE 문 사용 
EXECUTE mySQL USING @count; 

SELECT AVG(price) AS '평균가격' FROM buy;
SELECT CAST(AVG(price) AS SIGNED) '평균가격' FROM buy;
SELECT CONVERT(AVG(price) , SIGNED) '평균가격' FROM buy; -- 데이터 변환 

SELECT CAST('2022$12$22' AS DATE);

SELECT num, CONCAT(CAST(price AS CHAR), 'X', CAST(amount AS CHAR), '=') '가격X수량', price*amount '구매액' FROM buy;
-- CONCAT 문자 연결

-- member, buy 테이블 조인 
SELECT *
FROM buy
INNER JOIN member
ON buy.mem_id=member.mem_id;

-- 조인된 테이블에서 필요한 내용만 추출하기
SELECT buy.mem_id, mem_name, prod_name, addr, CONCAT(phone1, phone2) '연락처'
FROM buy
INNER JOIN member
ON buy.mem_id=member.mem_id;

-- 내부조인 중복결과 중 1개만 출력 
SELECT DISTINCT M.mem_id, M.mem_name, M.addr
FROM buy B
INNER JOIN member M
ON B.mem_id=M.mem_id
ORDER BY M.mem_id;
