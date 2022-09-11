-- 동적 SQL
USE market_db;
PREPARE myQuery FROM 'SELECT * FROM member WHERE mem_id="BLK"';
EXECUTE myQuery;
deallocate prepare myQuery;

-- 동적 SQL 활용
DROP TABLE IF EXISTS gate_table;
CREATE TABLE gate_table ( id INT auto_increment primary KEY, entry_time DATETIME);

SET @curDate = current_timestamp(); -- 현재 날짜/시간 입력

PREPARE myQuery FROM ' INSERT INTO gate_table VALUES (NULL, ?)';
EXECUTE myQuery USING @curDate;
deallocate prepare myQuery;

SELECT * FROM gate_table;