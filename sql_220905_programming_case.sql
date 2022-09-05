-- SQL 고급문법
-- case 문 : 학점출력

DROP PROCEDURE IF EXISTS caseProc;
DELIMITER $$
CREATE PROCEDURE caseProc()
BEGIN
	DECLARE point INT;
    DECLARE credit CHAR(1);
    SET point = 90;
    
CASE 
	WHEN point >= 90 THEN
		SET credit='A';
	WHEN point >= 80 THEN
		SET credit='B';
	WHEN point >= 70 THEN
		SET credit='C';
	WHEN point >= 60 THEN
		SET credit='D';
ELSE
	SET credit='F';
END CASE;
SELECT CONCAT('취득점수=> ',point), CONCAT('취득학점=> ',credit);
END $$
DELIMITER ;
CALL caseProc();

-- case 문 활용 
-- 구매금액 별 고객 등급 나누기

SELECT M.mem_id, M.mem_name, SUM(price*amount) "총 구매액",
	CASE 
		WHEN (SUM(price*amount) >=1500) THEN '최우수고객'
        WHEN (SUM(price*amount) >=1000) THEN '우수고객'
        WHEN (SUM(price*amount) >=1) THEN '일반고객'
	ELSE '유령고객'
	END "회원등급"
FROM buy B
	RIGHT OUTER JOIN member M
    ON B.mem_id=M.mem_id
GROUP BY M.mem_id
ORDER BY SUM(price*amount) DESC;

