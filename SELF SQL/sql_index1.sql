USE market_db;
CREATE TABLE table1 (
col1 INT PRIMARY KEY,
col2 INT,
col3 INT);

SHOW INDEX FROM table1;

USE market_db;
CREATE TABLE table2 (
col1 INT PRIMARY KEY,
col2 INT UNIQUE,
col3 INT UNIQUE);

SHOW INDEX FROM table2;

USE market_db;
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member (
mem_id CHAR(8),
mem_name VARCHAR(10),
mem_number INT,
addr CHAR(2) );

INSERT INTO member VALUES ('TWC','트와이스',9,'서울');
INSERT INTO member VALUES ('BLK','블랙핑크',4,'경남');
INSERT INTO member VALUES ('WMN','여자친구',6,'경기');
INSERT INTO member VALUES ('OMY','오마이걸',7,'제주');
SELECT * FROM member;

ALTER TABLE member
ADD CONSTRAINT
PRIMARY KEY (mem_id); -- id 를 기본키로 지정하면 클러스터형 인덱스 생성되어 정렬됨 
SELECT * FROM member;

ALTER TABLE member DROP PRIMARY KEY;
ALTER TABLE member
ADD CONSTRAINT
PRIMARY KEY (mem_name);
SELECT * FROM member;

INSERT INTO member VALUES('GRL','소녀시대',8,'서울');
SELECT * FROM member;

ALTER TABLE member DROP PRIMARY KEY;
ALTER TABLE member
ADD CONSTRAINT
UNIQUE (mem_name);
SELECT * FROM member;