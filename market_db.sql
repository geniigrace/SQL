USE market_db;

SELECT * FROM member;

SELECT mem_id, mem_name, debut_date FROM member 
ORDER BY debut_date;
 
SELECT mem_id, mem_name, debut_date FROM member 
ORDER BY debut_date DESC; 

SELECT mem_id, mem_name, debut_date,height FROM member
-- WHERE height >= 164
ORDER BY height DESC, debut_date ASC -- height 가 같은 경우, date가 빠른 그룹부터 
LIMIT 2,5;

SELECT DISTINCT addr FROM member;

SELECT * FROM buy;

SELECT mem_id, amount FROM buy ORDER BY mem_id;

SELECT mem_id, SUM(amount) FROM buy GROUP BY mem_id; --- 회원별 구매수량 

SELECT prod_name, SUM(amount) FROM buy GROUP BY prod_name; --- 제품별 판매수량

SELECT * FROM buy;

SELECT mem_id "회원아이디" , SUM(price*amount) "구매금액" 
FROM buy GROUP BY mem_id; -- 회원별 구매 금액alter

SELECT AVG(amount) "평균 구매 개수" FROM buy; -- 전체 평균 구매 수량 
 
SELECT mem_id "회원아이디", AVG(amount) "평균 구매 개수" FROM buy 
GROUP BY mem_id; -- 회원별 평균 구매 수량 

SELECT COUNT(phone2) "연락처 있는 회원" FROM member;

SELECT mem_id "회원ID" , SUM(price*amount) "총 구매금액" FROM buy
GROUP BY mem_id
HAVING SUM(price*amount)>=1000 -- 총 구매금액이 1000이상인 회원 
ORDER BY SUM(price*amount) DESC; -- 많이 산 사람부터 정렬 