-- SQL programming
-- WHILE 문

-- 1부터 100까지 합

DROP PROCEDURE IF EXISTS whileProc;
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
	DECLARE i INT;
    DECLARE hap INT;
    
    SET i=1;
    SET hap=0;
    
    WHILE (i<=100) DO
		SET hap=hap+i;
        SET i=i+1;
	END WHILE;
    
    SELECT '1부터 100까지 합 => ', hap;
    END $$
    
    DELIMITER ;
    CALL whileProc();
    
    -- 4배수를 제외한 1~100까지의 합. 총합은 1000미만
    
    drop procedure if exists whileProc2;
    delimiter $$
    create procedure whileProc2()
    begin
		declare i int;
        declare hap int;
        set i=1;
        set hap=0;
        
        myWhile:
        while(i<=100) do
			if(i%4=0) then
				set i=i+1;
                iterate myWhile;
			end if;
            set hap=hap+i;
            if (hap>1000) then
				leave myWhile;
			end if;
            set i=i+1;
		end while;
        select '4의 배수를 제외한 1~100까지 합(1000넘으면 종료) ==> ', hap;
	end $$
    delimiter ;

call whileProc2();

