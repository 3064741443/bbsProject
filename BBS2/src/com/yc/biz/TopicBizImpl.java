package com.yc.biz;

import java.util.ArrayList;
import java.util.List;

import com.yc.bean.Topic;
import com.yc.dao.DBHelper;


public class TopicBizImpl {
	private DBHelper db=new DBHelper();
	
	public void addTopic(Topic topic){
		String sql="insert into tbl_topic(topicid,title,content,publishtime,modifytime,id,boardid) values(seq_tbl_topic.nextval,?,?,sysdate, sysdate,?,?)";
		List<Object> params=new ArrayList<>();
		params.add(topic.getTitle());
		params.add(topic.getContent());
		params.add(topic.getId());
		params.add(topic.getBoardid());
		db.doUpdate(sql, params);
	}
	
	public Topic findTopicById(int topicid) throws Exception{
	     StringBuffer sb=new StringBuffer(" select a.*,nvl(b.num,0) as num ");
	     sb.append(" from(  ");
	     sb.append(" select topicid, title, content,to_char(publishtime,'yyyy-MM-dd') as publishtime,to_char(modifytime,'yyyy-MM-dd') as modifytime,tbl_user.id,uname,boardid ");
	     sb.append(" from tbl_topic ");
	     sb.append(" inner join tbl_user on tbl_topic.id=tbl_user.id ");
	     sb.append(" where topicid=? ");
	     sb.append("  ) a left join  ");
	     sb.append(" (select topicid,count(*) as num from tbl_reply where tbl_reply.topicid=? group by tbl_reply.topicid) b ");
	     sb.append("  on a.topicid=b.topicid ");
	     List<Object> params=new ArrayList<>();
	     params.add(topicid);
	     params.add(topicid);
	    List<Topic> list= db.findObject(sb.toString(), params, Topic.class);
	    return list==null || list.size()<=0? null:list.get(0);
	}
	
	public  List<Topic> findTopicByBoard(int boardid,int page,int pagesize) throws Exception{
		int start=(page-1)*pagesize+1;
		int end=page*pagesize;
		
		StringBuffer sb=new StringBuffer();
		sb.append(" select rn, a.topicid, title, content,to_char(publishtime,'yyyy-MM-dd') as publishtime,to_char(modifytime,'yyyy-MM-dd') as modifytime,id, uname,boardid, NVL(num, 0) as num ");
		sb.append(" from (select * from ( select rownum rn, t.topicid as topicid ,t.title as title, t.content as content, ");
		sb.append(" t.publishtime as publishtime, t.modifytime as modifytime, t.id as id, ");
		sb.append(" u.uname as uname , t.boardid as boardid from tbl_topic t inner join tbl_user u on t.id=u.id ");
		sb.append(" where boardid=? ) where rn>=? and rn<=? order by modifytime desc ) a ");
		sb.append(" left join ( select topicid,  count(*) as num from tbl_reply group by tbl_reply.topicid ");
		sb.append("  ) b on a.topicid=b.topicid ");
		List<Object> params=new ArrayList<>();
	    params.add(boardid);
	    params.add(start);
	    params.add(end);
		
			List<Topic> list=db.findObject(sb.toString(), params, Topic.class);	
		return list;
	}
}
