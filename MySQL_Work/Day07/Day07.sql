use sqldb;
drop procedure if exists userProc1;
delimiter $$
create procedure userProc1(in userName varchar(10))
begin
select * from userTBL where userName = userName;
end $$
delimiter ;

call userProc1('조관우');


drop procedure if exists userProc2;
delimiter $$
create procedure userProc2(
in userBirth int,
in userHeight int)
begin
select * from userTBL
where birthYear > userBirth and height > userHeight;
end $$
delimiter ;

call userProc2(1970, 178);


drop procedure if exists userProc3;
delimiter $$
create procedure userProc3(
in txtValue char(10),
out outValue int)
begin
insert into testTBL values(null, txtValue);
select max(id) into outValue from testTBL;
end $$
delimiter ;

create table if not exists testTBL(
id int auto_increment primary key,
txt char(10)
);
call userProc3 ('테스트값', @myValue);

select concat('현재 입력된 id 값 ==> ', @myValue);

drop procedure if exists ifelseProc;
delimiter $$
create procedure ifelseProc(
in uName varchar(10)
)
begin
declare bYear int;
select birthYear into bYear from userTBL
where userName = userName;
if(bYear >= 1980) then
select '아직젋군요';
else
select '나이가 지긋하군요';
end if;
end $$
delimiter ;

call ifelseProc('조용필');

drop procedure if exists caseProc;
delimiter $$
create procedure caseProc(
in userName varchar(10
)
begin
declare bYear int;
declare tti char(3);
select birthYear into bYear from userTBL
where userName=userName;
case
when (bYear%12 =0) then set tti='원숭이';
when (bYear%12 =1) then set tti='닭';
when (bYear%12 =2) then set tti='개';
when (bYear%12 =3) then set tti='돼지';
when (bYear%12 =4) then set tti='쥐';
when (bYear%12 = 5) then set tti = '소';
when (bYear%12 = 6) then set tti = '호랑이';
when (bYear%12 = 7) then set tti = '토끼';
when (bYear%12 = 8) then set tti = '용';
when (bYear%12 = 9) then set tti = '뱀';
when (bYear%12 =10) then set tti = '말';
else set tti = '양';
end case;
 select concat(userName, '의 띠 ==> ',tti);
 end $$
 delimiter ;
 call caseProc ('김범수');
 
 
 create database if not exists testdb;
 use testdb;
 create table if not exists testTBL (id int, txt varchar(10));
 insert into testTBL values(1, '레드벨벳');
 insert into testTBL values(2,'잇지');
 insert into testTBL values(3, '블랙핑크');
 
 drop trigger if exists testTrg;
 delimiter //
 create trigger testTrg -- 트리거 생성 
 after delete -- 삭제된 이후에 
 on testTBL -- 이 테이블에 붙이고 
 for each row -- 각 행마다 붙임 
 begin
 set @msg = '가수 그룹이 삭제됨'; -- 삭제되면 이 메세지가 세팅됨 
 end //
 delimiter ;
 
 set @msg = '';
 insert into testTBL values(4,'마마무');
 select @msg;
 update testTBL set txt ='블핑' where id =3;
 select @msg;
 delete from testTBL where id =4;
 select @msg;
 
 use sqldb;
-- drop table buyTBL;
 create table backup_userTBL
 ( userID char(8) not null primary key,
 userName varchar(10) not null,
 birthYear int not null,
 addr char(2) not null,
 mobile1 char(3),
 mobile2 char(8),
 height smallint,
 mDate date,
 modType char(2),
 modDate date,
 modUser varchar(256)
 );
 
 drop trigger if exists backUserTBL_DeleteTrg;
 delimiter //
 create trigger backUserTBL_DeleteTrg
 after delete
 on userTBL
 for each row
 begin
 insert into backup_userTBL values( old.userID, old.userName, old.birthYear, old.addr, old.mobile1, old.mobile2, old.height, old.mDate,
 '삭제',curdate(), current_user() );
 end //
 delimiter ;
 
 delete from userTBL where height >= 177;
 
 select * from backup_userTBL;
 
 select * from 대리점; 
 