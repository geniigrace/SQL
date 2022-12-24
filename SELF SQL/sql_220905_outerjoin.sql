-- # 외부조인 기본 구문
USE market_db; 
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr
FROM member M -- LEFT 테이블 : member 
LEFT OUTER JOIN buy B -- RIGHT 테이블 : buy, left 기준으로 외부조인 
ON M.mem_id=B.mem_id
ORDER BY M.mem_id;

-- # 외부조인 활용 : 회원가입 이후 구매 한번도 안한 회원 조회
SELECT DISTINCT M.mem_id, M.mem_name, B.prod_name, M.addr
FROM member M
LEFT OUTER JOIN buy B
ON M.mem_id = B.mem_id
WHERE B.prod_name IS NULL -- B.prod_name 이 NULL 인 열 조회 
ORDER By M.mem_id;


-- 자체조인 : 사내 조직도
USE market_db;
CREATE TABLE emp_table (emp CHAR(4), manager CHAR(4), phone VARCHAR(8));
INSERT INTO emp_table VALUES ('대표', NULL, '0000');
INSERT INTO emp_table VALUES ('영업이사', '대표', '1111');
INSERT INTO emp_table VALUES ('관리이사', '대표', '2222');
INSERT INTO emp_table VALUES ('정보이사','대표','3333');
INSERT INTO emp_table VALUES ('영업과장','영업이사','1111-1');
INSERT INTO emp_table VALUES ('경리부장','관리이사','2222-1');
INSERT INTO emp_table VALUES ('인사부장','관리이사','2222-2');
INSERT INTO emp_table VALUES ('개발팀장','정보이사','3333-1');
INSERT INTO emp_table VALUES ('개발주임','정보이사','3333-1-1');

SELECT * FROM emp_table;

SELECT A.emp "직원", B.emp "직속상관", B.phone "직속상관연락처"
FROM emp_table A
INNER JOIN emp_table B
ON A.manager = B.emp;
-- WHERE A.emp='경리부장'; 왜 구문 오류가 생기는 걸까 



