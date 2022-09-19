-- 트리거 실습

use market_db;
create table if not exists trigger_table(id int, txt varchar(10));
insert into trigger_table values(1, '레드벨벳');
insert into trigger_table values(2, '잇지');
insert into trigger_table values(3, '블랙핑크');

-- 트리거 생성 및 부착
drop trigger if exists myTrigger;
delimiter $$
create trigger myTrigger -- 트리거 이름 지정 및 선언 
after delete -- delete 이후에 실행 
on trigger_table -- 트리거 부착할 테이블 지정 
for each row -- 행마다 진행 
begin
set @msg='가수 그룹이 삭제됨';
end $$
delimiter ;

insert into trigger_table values(4, '마마무');
select @msg; -- insert 문이므로 @msg 아무것도 출력 안됨

update trigger_table set txt='블핑' where id =3;
select @msg; 
select * from trigger_table; 
-- update 문이 실행되었지만 delete 문이 아니므로 @msg는 출력 안됨

delete from trigger_table where id =4;
select @msg;

-- 트리거를 사용하여 자료 수정/삭제에 대비한 백업
use market_db;
create table singer(select mem_id, mem_name, mem_number, addr from member);
-- create table~selct~ 문을 사용하면 테이블을 복사하여 새 테이블을 만들수 있음
select * from singer;

-- 백업 테이블 만들기
use market_db;
drop table if exists backup_singer;
create table backup_singer (
mem_id CHAR(8) not null,
mem_name varchar(20) not null,
mem_number int not null,
addr char(2) not null,
modType char(2),
modDate DATE,
modUser varchar(30) );

select * from backup_singer;


-- 수정 트리거 만들기
drop trigger if exists updateTrg;
delimiter $$
create trigger updateTrg
after update -- update 문 이후에 실행 
on singer
for each row -- 한 행씩 진행 
begin
insert into backup_singer values( old.mem_id, old.mem_name, old.mem_number, old.addr, '수정',
curdate(), current_user());

end $$
delimiter ;

-- 삭제 트리거 만들기

drop trigger if exists deleteTrg;
delimiter $$
create trigger deleteTrg
after delete
on singer
for each row
begin
insert into backup_singer values (old.mem_id, old.mem_name, old.mem_number, old.addr, '삭제',
curdate(), current_user() );

end $$
delimiter ;

-- 데이터 수정, 삭제 해보기 

update singer set addr = '영국' where mem_id = 'BLK';
update singer set mem_name = '소시' where mem_id = 'GRL';
update singer set mem_id = 'MMM' where mem_id = 'MMU';

delete from singer where addr = '경기';
delete from singer where mem_name='트와이스';

-- 백업 테이블 확인
select * from backup_singer;