-- SQL 프로그래밍
-- IF문

DROP PROCEDURE IF EXISTS ifProc1;

DELIMITER $$
CREATE PROCEDURE ifProc1()
BEGIN
	IF 100=100 THEN
		SELECT '100은 100과 같다.';
	END IF;
END $$
DELIMITER ;

CALL ifProc1();

-- IF ELSE 문
DROP PROCEDURE IF EXISTS ifProc2;
DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
	DECLARE myNum INT;
    SET myNum = 100;
    IF myNum =100 THEN
		SELECT '100 입니다.';
	ELSE 
		SELECT '100이 아닙니다.';
	END IF;
END $$
DELIMITER ;

CALL ifProc2();

-- IF 문 활용

DROP PROCEDURE IF EXISTS ifProc3;
DELIMITER $$
CREATE PROCEDURE ifProc3()
BEGIN
	DECLARE debutDate DATE; -- 데뷔일자 
    DECLARE curDate DATE; -- 오늘 날짜
    DECLARE days INT; -- 일수
    
SELECT debut_date INTO debutDate 
FROM market_db.member
WHERE mem_id='APN';

SET curDate = current_date();
SET days = DATEDIFF(curDate,debutDate);

IF (days/365) >=100 THEN
	SELECT CONCAT('데뷔한 지 ',days,'일이 지났습니다. 축하합니다~');
ELSE 
	SELECT CONCAT('데뷔한 지',days,'일 입니다.');
END IF;
END $$
DELIMITER ;

CALL ifProc3();
