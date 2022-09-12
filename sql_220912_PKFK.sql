-- DB 테이블 생성하기
-- PK, FK 설정하기 

DROP DATABASE IF EXISTS naver_db;
CREATE DATABASE naver_db;

USE naver_db;
DROP TABLE IF EXISTS member;
CREATE TABLE member
(
mem_id CHAR(8) NOT NULL PRIMARY KEY,
mem_name VARCHAR(10) NOT NULL,
mem_number TINYINT NOT NULL,
addr CHAR(2) NOT NULL,
phone1 CHAR(3) NULL,
phone2 CHAR(8) NULL,
height TINYINT unsigned NULL,
debut_date DATE null
);

DROP TABLE IF EXISTS buy;
CREATE TABLE buy
( num INT auto_increment NOT NULL PRIMARY KEY,
user_id CHAR(8) NOT NULL,
prod_name CHAR(6) NOT NULL,
group_name CHAR(4) NULL,
price INT UNSIGNED NOT NULL,
amount smallint unsigned not null,
FOREIGN KEY(user_id) REFERENCES member(mem_id)
ON UPDATE CASCADE
ON DELETE CASCADE);

insert into member values ('TWC', '트와이스', 9, '서울', '02','11111111', 167, '2015-10-19');
insert into member values ('BLK', '블랙핑크', 4, '경남', '055','22222222', 163, '2016-08-08');
insert into member values ('WMN', '여자친구', 6, '경기', '031','33333333', 166, '2015-01-15');

select * from member;

INSERT INTO buy values (NULL, 'BLK', '지갑', null, 30, 2);
insert into buy values ( null, 'BLK','맥북프로', '디지털', 1000, 1);
-- insert into buy values (null, 'APN', '아이폰','디지털',200,1);

select * from buy;

select M.mem_id, M.mem_name, B.prod_name
FROM buy B
INNER JOIN member M
ON B.user_id=M.mem_id;

UPDATE member SET mem_id = 'PINK' WHERE mem_id='BLK';

