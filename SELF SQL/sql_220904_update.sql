SELECT COUNT(*) FROM market_db.member; -- 테이블의 개수 
DESC market_db.member;
SELECT * FROM market_db.member LIMIT 5;

SELECT * FROM market_db.member;

USE market_db;

UPDATE member
SET mem_name='ITZY'
WHERE mem_name='잇지';

SELECT * FROM member WHERE mem_name='ITZY';

UPDATE member
SET mem_name='SNSD', height=172
WHERE mem_name='소녀시대';

SELECT * FROM member;

UPDATE member
SET height = height/100;
SELECT * FROM member; 

CREATE TABLE big_tagle1 (SELECT * FROM market_db.member);

SELECT mem_id, amount FROM buy ORDER BY mem_id;

SELECT mem_id, SUM(amount) FROM buy GROUP BY mem_id;
