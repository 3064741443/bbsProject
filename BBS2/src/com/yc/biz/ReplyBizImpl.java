package com.yc.biz;

import java.util.ArrayList;
import java.util.List;

import com.yc.bean.Reply;
import com.yc.bean.Topic;
import com.yc.dao.DBHelper;

public class ReplyBizImpl {
	private DBHelper db=new DBHelper();
	
	public void modifyReply(Reply reply){
   	 String sql=" update tbl_reply set title=?,content=?,modifytime=sysdate where replyid=? ";
   	List<Object> params=new ArrayList<>();
    params.add(reply.getTitle());
    params.add(reply.getContent());
    params.add(reply.getReplyid());
    db.doUpdate(sql.toString(), params);
    }
	
     public void delReply(int replyid){
    	 String sql=" delete from tbl_reply where replyid=? ";
    	 List<Object> params=new ArrayList<>();
    	 params.add(replyid);
    	 db.doUpdate(sql, params);
     }
	
	  public void addReply(Reply reply){
		  StringBuffer sql =new StringBuffer("insert into tbl_reply(replyid,title,content,publishtime,modifytime,id,topicid)");
          sql.append(" values(seq_tbl_reply.nextval,?,?,sysdate,sysdate,?,?)");
          List<Object> params=new ArrayList<>();
          params.add(reply.getTitle());
          params.add(reply.getContent());
          params.add(reply.getId());
          params.add(reply.getTopicid());
          db.doUpdate(sql.toString(), params);
	  }
      public List<Reply> findReplyByTopic(int topicid,int pages,int pagesize) throws Exception{
    	int start=(pages-1)*pagesize+1;
  		int end=pages*pagesize;
  		
  		StringBuffer sb=new StringBuffer();
  		sb.append(" select * from( ");
  		sb.append(" select rownum rn,t.replyid as replyid,t.title as title,t.content as content, ");
  		sb.append(" to_char(t.publishtime,'yyyy-MM-dd HH:mi:ss') as publishtime,to_char(t.modifytime,'yyyy-MM-dd HH:mi:ss') as modifytime,t.id as id, ");
  		sb.append(" u.uname as uname,u.head as head,to_char(u.regtime,'yyyy-MM-dd HH:mi:ss') as regtime,t.topicid as topicid ");
  		sb.append(" from tbl_reply t  ");
  		sb.append(" inner join tbl_user u on t.id=u.id ");
  		sb.append(" where topicid=? order by modifytime desc ");
  		sb.append("  )where rn>=? and rn<=? ");
  		
  		List<Object> params=new ArrayList<>();
  	    params.add(topicid);
  	    params.add(start);
  	    params.add(end);
  		
  			List<Reply> list=db.findObject(sb.toString(), params, Reply.class);	
  		return list;
    	  
      }
}
