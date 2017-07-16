create database BBS
-原始表结构及数据如下:
create table tbl_user(
	id int primary key ,
	uname varchar(20),
	upass varchar(100),
	head varchar(100),
	regtime datetime,
	gender int
);

create sequence seq_tbl_user;

insert into tbl_user (id, uname,upass,head,regtime,gender) values(seq_tbl_user.nextval, 'a','a','1.gif',sysdate,1);
insert into tbl_user (id, uname,upass,head,regtime,gender) values(seq_tbl_user.nextval,'b','b','2.gif',sysdate,1);

--版块   自联接的表
create table tbl_board(
	boardid int primary key ,
	boardname varchar2(50),
	parentid int
);

create sequence seq_tbl_board;

insert into tbl_board(boardid, boardname,parentid) values(seq_tbl_board.nextval,'.net',0);
insert into tbl_board(boardid,boardname,parentid) values(seq_tbl_board.nextval,'java',0);
insert into tbl_board(boardid,boardname,parentid) values(seq_tbl_board.nextval,'db',0);
insert into tbl_board(boardid,boardname,parentid) values(seq_tbl_board.nextval,'project',0);

insert into tbl_board(boardid,boardname,parentid) values(seq_tbl_board.nextval,'ado.net',1);
insert into tbl_board(boardid,boardname,parentid) values(seq_tbl_board.nextval,'asp.net',1);
insert into tbl_board(boardid,boardname,parentid) values(seq_tbl_board.nextval,'vb.net',1);

insert into tbl_board(boardid,boardname,parentid) values(seq_tbl_board.nextval,'jsp',2);
insert into tbl_board(boardid,boardname,parentid) values(seq_tbl_board.nextval,'struts',2);
insert into tbl_board(boardid,boardname,parentid) values(seq_tbl_board.nextval,'hibernate',2);

insert into tbl_board(boardid,boardname,parentid) values(seq_tbl_board.nextval,'sql',3);
insert into tbl_board(boardid,boardname,parentid) values(seq_tbl_board.nextval,'oracle',3);
insert into tbl_board(boardid,boardname,parentid) values(seq_tbl_board.nextval,'mysql',3);

--主题帖
create table tbl_topic(
	topicid int primary key ,
	title varchar2(50),
	content varchar2(1000),
	publishtime timestamp,
	modifytime timestamp,
	id int,
	boardid int
);

create sequence seq_tbl_topic;

insert into tbl_topic(topicid,title,content,publishtime,modifytime,id,boardid) 
values(seq_tbl_topic.nextval,'jsp  good',' good,i agree',sysdate, sysdate,1,8);

insert into tbl_topic(topicid,title,content,publishtime,modifytime,id,boardid) 
values(seq_tbl_topic.nextval,'jsp is very good','very good,i agree',sysdate, sysdate,1,8);

insert into tbl_topic(topicid,title,content,publishtime,modifytime,id,boardid) 
values(seq_tbl_topic.nextval,'jsp is very good','very good,i agree',sysdate, sysdate,1,8);

insert into tbl_topic(topicid,title,content,publishtime,modifytime,id,boardid) 
values(seq_tbl_topic.nextval,'jsp is very good','very good,i agree',sysdate, sysdate,1,8);

insert into tbl_topic(topicid,title,content,publishtime,modifytime,id,boardid) 
values(seq_tbl_topic.nextval,'jsp is very good','very good,i agree',sysdate, sysdate,1,8);

insert into tbl_topic(topicid,title,content,publishtime,modifytime,id,boardid) 
values(seq_tbl_topic.nextval,'ado.net is very good','very good,i agree',sysdate, sysdate,2,5);

alter table tbl_topic
   add constraint FK_topic_id
      foreign key(id) references tbl_user(id);
      
alter table tbl_topic
   add constraint FK_topic_boardid
     foreign key(boardid) references tbl_board(boardid);
     
     

--跟贴   
create table tbl_reply(
	replyid int primary key ,
	title varchar2(50),
	content varchar2(1000),
	publishtime timestamp,
	modifytime timestamp,
	id int,
	topicid int
);




create sequence seq_tbl_reply;

alter table tbl_reply
   add constraint FK_reply_uid
      foreign key(id) references tbl_user(id);
      
alter table tbl_reply
	add constraint FK_reply_topicid
	   foreign key(topicid) references tbl_topic(topicid);
     
     
--观察4张表的数据
select * from tbl_user;
select * from tbl_board;
select * from tbl_topic;
select * from tbl_reply;









--案例需求: 请用一次查询得到界面中所有要求显示的数据
--步骤:1. 先查出每个版块最新贴子的发贴时间
select boardid,max(modifytime) as modifytime
			from tbl_topic
			group by boardid
--步骤:2. 查出每个贴子的信息，关键是贴子的发贴人名.
select topicid, title, modifytime, uname, boardid
		from tbl_topic
		left join tbl_user
		on tbl_topic.id=tbl_user.id
--步骤:3. 将以上整合，得到每个版块最新的贴子信息
select topicid,title,a.modifytime,uname,a.boardid
	from
	(	select topicid, title, modifytime, uname, boardid
		from tbl_topic
		left join tbl_user
		on tbl_topic.id=tbl_user.id
        ) a,
		(
			select boardid,max(modifytime) as modifytime
			from tbl_topic
			group by boardid
		) b
	where  a.boardid=b.boardid and a.modifytime=b.modifytime
  
---------------------------------------------------------------------
  



--步骤:4. 统计每个版块下的贴子总数
select tbl_board.boardid,boardname,parentid , count( topicid ) as total
	from tbl_board
	left join tbl_topic
	on tbl_board.boardid=tbl_topic.boardid
	group by tbl_board.boardid,boardname,parentid 
  
  
  
  
  
  
--步骤:5. 最后使用左外联接，将版块信息与最新的贴子信息整合在一起. 
select a.boardid,boardname,parentid,total, topicid,title,modifytime,uname
from
(
	select tbl_board.boardid,boardname,parentid , count( topicid ) as total
	from tbl_board
	left join tbl_topic
	on tbl_board.boardid=tbl_topic.boardid
	group by tbl_board.boardid,boardname,parentid 
) a
left join 
(
	select topicid,title,a.modifytime,uname,a.boardid
	from
	(	select topicid, title, modifytime, uname, boardid
		from tbl_topic
		left join tbl_user
		on tbl_topic.id=tbl_user.id
        ) a,
		(
			select boardid,max(modifytime) as modifytime
			from tbl_topic
			group by boardid
		) b
	where  a.boardid=b.boardid and a.modifytime=b.modifytime
)b
on a.boardid=b.boardid







--------------------------------------------------------
--需求二: 求出某个版块下按分页条件查询的贴子. 
-- 输出要求: 1. 分页    2. 统计每个贴子下有多少回复数  3. 某一个版块
-- 图片二的效果
--------------------------------------------------------
--基础数据
--插入回复
insert into tbl_reply(replyid,title,content,publishtime,modifytime,id,topicid) 
values(seq_tbl_reply.nextval,'jsp is very good reply','very good,i agree, reply',sysdate,sysdate,1,2);

insert into tbl_reply(replyid,title,content,publishtime,modifytime,id,topicid) 
values(seq_tbl_reply.nextval,'jsp is very good reply','very good,i agree, reply',sysdate,sysdate,1,2);

insert into tbl_reply(replyid,title,content,publishtime,modifytime,id,topicid) 
values(seq_tbl_reply.nextval,'jsp is very good reply','very good,i agree, reply',sysdate,sysdate,1,2);

insert into tbl_reply(replyid,title,content,publishtime,modifytime,id,topicid)
 values(seq_tbl_reply.nextval,'jsp is very good reply','very good,i agree, reply',sysdate,sysdate,1,2);
 
insert into tbl_reply(replyid,title,content,publishtime,modifytime,id,topicid) 
values(seq_tbl_reply.nextval,'jsp is very good reply','very good,i agree, reply',sysdate,sysdate,1,2);


--步骤一: 按贴子编号分组查出每个贴子下的回复数
select topicid, count(*) as total 
from tbl_reply
group by topicid;

--步骤二: 查出某个版块(比如8号版块)下所有的贴子 
select topicid,title,content,publishtime,modifytime,  tbl_user.id,  uname,boardid
from tbl_topic
inner join tbl_user
on tbl_topic.id=tbl_user.id
where boardid=8
order by modifytime desc

--步骤三: 加入分页查询
select * from(
    select rownum as rn, topicid,title,content,publishtime,modifytime,  tbl_user.id,  uname,boardid
    from tbl_topic
    inner join tbl_user
    on tbl_topic.id=tbl_user.id
    where boardid=8
    order by modifytime desc
) where rn>0 and rn<=2


--步骤四: 以左外联接查询求出
select a.topicid,title,content,publishtime,modifytime,uid,uname,boardid, total
from
      (
      select * from(
                select rownum as rn, topicid,title,content,publishtime,modifytime,  tbl_user.id,  uname,boardid
                from tbl_topic
                inner join tbl_user
                on tbl_topic.id=tbl_user.id
                where boardid=8
                order by modifytime desc
            ) where rn>4 and rn<=6) a
left join 
      (select topicid, count(*) as total from tbl_reply
      group by topicid) b
on a.topicid=b.topicid



