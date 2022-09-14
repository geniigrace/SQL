-- 인덱스 실습

SHOW INDEX FROM member;

SHOW TABLE STATUS LIKE 'member';

CREATE INDEX idx_member_addr
ON member(addr);

SHOW INDEX FROM member;

CREATE UNIQUE INDEX idx_mem_number
ON member (mem_number);
-- 이 구문은 오류를 발생한다. mem_number 에 4가 중복되기 때문

CREATE UNIQUE INDEX idx_mem_name
ON member (mem_name);
-- 고유 보조 인덱스로 지정한 후에는 중복되는 값은 입력할 수 없다. 

ANALYZE TABLE member;
SHOW INDEX FROM member;

SELECT * FROM member;

SELECT mem_id, mem_name, addr FROM member;

SELECT mem_id, mem_name, addr FROM member
WHERE mem_name ='에이핑크';

SHOW INDEX FROM member;

DROP INDEX idx_member_addr ON member;

ALTER TABLE member DROP PRIMARY KEY;

-- 기본키를 삭제하기 전에 외래키를 알아보는 방법 
SELECT table_name, constraint_name
FROM information_schema.referential_constraints -- mysql 안에 원래 포함되어있는 시스템 db 테이블 이다. 여기에 mysql 전체 외래키 정보가 포함되어 있음

WHERE constraint_schema = 'market_db';


ALTER TABLE buy
DROP FOREIGN KEY buy_ibfk_1; -- 외래키 삭제 

ALTER TABLE member
DROP PRIMARY KEY; -- 기본키 삭제 