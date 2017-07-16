create database BBS
-ԭʼ��ṹ����������:
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

--���   �����ӵı�
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

--������
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
     
     

--����   
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
     
     
--�۲�4�ű������
select * from tbl_user;
select * from tbl_board;
select * from tbl_topic;
select * from tbl_reply;









--��������: ����һ�β�ѯ�õ�����������Ҫ����ʾ������
--����:1. �Ȳ��ÿ������������ӵķ���ʱ��
select boardid,max(modifytime) as modifytime
			from tbl_topic
			group by boardid
--����:2. ���ÿ�����ӵ���Ϣ���ؼ������ӵķ�������.
select topicid, title, modifytime, uname, boardid
		from tbl_topic
		left join tbl_user
		on tbl_topic.id=tbl_user.id
--����:3. ���������ϣ��õ�ÿ��������µ�������Ϣ
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
  



--����:4. ͳ��ÿ������µ���������
select tbl_board.boardid,boardname,parentid , count( topicid ) as total
	from tbl_board
	left join tbl_topic
	on tbl_board.boardid=tbl_topic.boardid
	group by tbl_board.boardid,boardname,parentid 
  
  
  
  
  
  
--����:5. ���ʹ���������ӣ��������Ϣ�����µ�������Ϣ������һ��. 
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
--�����: ���ĳ������°���ҳ������ѯ������. 
-- ���Ҫ��: 1. ��ҳ    2. ͳ��ÿ���������ж��ٻظ���  3. ĳһ�����
-- ͼƬ����Ч��
--------------------------------------------------------
--��������
--����ظ�
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


--����һ: �����ӱ�ŷ�����ÿ�������µĻظ���
select topicid, count(*) as total 
from tbl_reply
group by topicid;

--�����: ���ĳ�����(����8�Ű��)�����е����� 
select topicid,title,content,publishtime,modifytime,  tbl_user.id,  uname,boardid
from tbl_topic
inner join tbl_user
on tbl_topic.id=tbl_user.id
where boardid=8
order by modifytime desc

--������: �����ҳ��ѯ
select * from(
    select rownum as rn, topicid,title,content,publishtime,modifytime,  tbl_user.id,  uname,boardid
    from tbl_topic
    inner join tbl_user
    on tbl_topic.id=tbl_user.id
    where boardid=8
    order by modifytime desc
) where rn>0 and rn<=2


--������: ���������Ӳ�ѯ���
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



