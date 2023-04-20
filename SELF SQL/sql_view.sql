-- 뷰
USE market_db;
CREATE VIEW v_member
AS
SELECT mem_id, mem_name, addr FROM member;

select * from v_member;

SELECT mem_name, addr FROM v_member
WHERE addr IN ('서울','경기');

SELECT B.mem_id, M.mem_name, B.prod_name, M.addr,
CONCAT(M.phone1, M.phone2) '연락처'
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id;

SELECT * FROM buy;

CREATE VIEW v_memberbuy
AS
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr,
CONCAT(M.phone1, M.phone2) '연락처'
FROM buy B
INNER JOIN member M
ON B.mem_id=M.mem_id;

SELECT * FROM v_memberbuy WHERE mem_name = '블랙핑크';

USE market_db;
CREATE VIEW v_viewtest1 -- 뷰의 생성 
AS
SELECT B.mem_id 'Member ID', M.mem_name AS 'Member Name',
B.prod_name "Product Name", CONCAT(M.phone1, M.phone2) AS "Office Phone"
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id;

SELECT DISTINCT `Member ID`, `Member Name` FROM v_viewtest1;
-- 띄어쓰기 있는 경우 백틱으로 묶어줌 


ALTER VIEW v_viewtest1 -- 뷰 수정 
AS
SELECT B.mem_id '회원 아이디', M.mem_name AS '회원 이름',
B.prod_name "제품 이름", CONCAT(M.phone1, M.phone2) AS "연락처"
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id;

SELECT DISTINCT `회원 아이디`,`회원 이름` FROM v_viewtest1; -- 중복없이 조회 

DROP VIEW v_viewtest1; -- 뷰 삭제 


USE market_db;
CREATE OR REPLACE VIEW v_viewtest2 -- 기존에 동일이름의 뷰가 있다면 그 위에 덮어쓰기
AS
SELECT mem_id, mem_name, addr FROM member;

DESCRIBE v_viewtest2; -- 뷰 정보

DESC v_viewtest2; -- DESCRIBE 의 줄임 // 키 정보는 포함되지않음 

SHOW CREATE VIEW v_viewtest2; -- 뷰의 소스코드 확인 

UPDATE v_member SET addr ='부산'WHERE mem_id='BLK';

SELECT * FROM v_member;

INSERT INTO v_member(mem_id, mem_name, addr) VALUES ('BTS','방탄','경기');
-- 뷰에서 참조하는 member 에는 mem_number 가 not null 설정 되어있음
-- 뷰에는 mem_number 가 포함되지 않으므로 자료를 추가하면 null 상태가 되기때문에 오류\

-- 지정한 범위의 뷰 만들기
CREATE VIEW v_height167
AS
SELECT * FROM member WHERE height >=167;
SELECT * FROM v_height167;

DELETE FROM v_height167 WHERE height <167;

INSERT INTO v_height167 VALUES ('TRA','티아라',6,'서울',null,null,159,'2005-01-01');
-- 새로 추가한 TRA는 167 미만이므로 추가 문법 실행은 가능하지만 db에는 작성되지 않음

ALTER VIEW v_height167
AS
SELECT * FROM member WHERE height>=167
WITH CHECK OPTION; -- 해당범위 미만/초과 하는 값은 아예 입력 안되게 설정 
INSERT INTO v_height167 VALUES('TOA','텔레토뷔',4,'영국',null,null,140,'1995-01-01');

-- 복합뷰
CREATE VIEW v_complex
AS
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id;

-- 뷰의 상태 확인
CHECK TABLE v_height167;