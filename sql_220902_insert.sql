-- 데이터를 변경하는 SQL 

USE market_db;
CREATE TABLE hongong1 (toy_id INT, toy_name CHAR(4), age INT); -- 열 3개인 테이블 생성
INSERT INTO hongong1 VALUES (1, '우디', 25); -- 행데이터 1개 입력
INSERT INTO hongong1 (toy_id, toy_name) VALUES (2, '버즈'); -- 버즈의 age 에는 NULL 
SELECT * FROM hongong1; -- 만들어진 테이블 확인

INSERT INTO hongong1 (toy_name, age, toy_id) VALUES ('제시', 20,3); -- 입력순서 변경 

-- 자동으로 증가하는 AUTO_INCREMENT

CREATE TABLE hongong2(
  toy_id INT auto_increment primary key, -- 자동으로 숫자 증가 , 기본키 지정
  toy_name CHAR(4),
  age INT);
  
  INSERT INTO hongong2 VALUES (NULL, '보핍', 25);
  INSERT into hongong2 values (null, '슬링키', 22);
  insert into hongong2 values (null, '렉스', 21); -- 기본키는 짜동으로 증가하도록 되어있으므로 null 값 입력
  
  select * from hongong2;
  
SELECT last_INSERT_ID();
 
 alter table hongong2 auto_increment=100; -- 100부터 자동으로 숫자 증가
 insert into hongong2 values (null, '재남', 35);
 insert into hongong2 values (null, '추가', 30);
 select * from hongong2;
 
 create table hongong3(
 toy_id int auto_increment primary key,
 toy_name char(4),
 age int);
 
 alter table hongong3 auto_increment=1000; -- 1000부터 숫자 증가
 set @@auto_increment_increment=3; -- 3씩 증가
 
 insert into hongong3 values(null, '이름1', 10),(null, '이름2', 20), (null, '이름3', 30); -- 데이터 한줄로 입력하기 
 select * from hongong3;
 
