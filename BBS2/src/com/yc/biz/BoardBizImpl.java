package com.yc.biz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.yc.bean.Topic;
import com.yc.bean.Board;
import com.yc.dao.DBHelper;

//这里面写业务层     相当于业务bean

public class BoardBizImpl{
	private DBHelper db=new DBHelper();
	/**
	 * 查找所有的版块及每个版块信息
	 * Map<Integer,List<Board>>
	 * 0 
	 * 1
	 * 2
	 * 3
	 * @return
	 */
	
	public Map<Integer,List<Board>> findAllBoard(){
		Map<Integer,List<Board>> map=new HashMap<Integer,List<Board>>();
		String sql="select a.boardid,boardname,parentid,total, topicid,title,to_char(modifytime,'yyyy-MM-dd HH:mm:ss') as modifytime,uname from(select tbl_board.boardid,boardname,parentid , count( topicid ) as total from tbl_board left join tbl_topic on tbl_board.boardid=tbl_topic.boardid group by tbl_board.boardid,boardname,parentid ) a left join (select topicid,title,a.modifytime,uname,a.boardid from(  select topicid, title, modifytime, uname, boardid from tbl_topic left join tbl_user on tbl_topic.id=tbl_user.id) a,( select boardid,max(modifytime) as modifytime from tbl_topic group by boardid) b where  a.boardid=b.boardid and a.modifytime=b.modifytime)b on a.boardid=b.boardid";
		List<Map<String,Object>> list=db.findMultiObject(sql, null);
		if(list!=null && list.size()>0){
			for(Map<String,Object> m:list){
				Integer boardid=Integer.parseInt(m.get("BOARDID").toString());
				String boardname=m.get("BOARDNAME").toString();
				Integer parentid=Integer.parseInt(m.get("PARENTID").toString());
				Integer total=Integer.parseInt(m.get("TOTAL").toString());
				Topic t=null;
				if(m.get("TOPICID")!=null){
					Integer topicid=Integer.parseInt(m.get("TOPICID").toString());
					String title=m.get("TITLE").toString();
					String modifytime=m.get("MODIFYTIME").toString();
					String uname=m.get("UNAME").toString();
			        t=new Topic(topicid,title,modifytime,uname);
					
				}
				Board b=new Board(boardid,boardname,parentid,total,t);
				//取出b中的parentid,到map中判断是否有这个父板块编号（键） map.containKey()
				// 如果没有这个键，将b中的parentid 当成键，另外再创建一个list<Board> ,将当前这个b存到list中，再将list存到map中
				//如果有这个键，从map中根据parentid 取出值List<Board> ,将b存到这个list即可
				if(map.containsKey(b.getParentid())){
					List<Board> sonList=map.get(b.getParentid());
					sonList.add(b);
					
				}else{
					List<Board> sonList=new ArrayList<>();
					sonList.add(b);
					map.put(b.getParentid(), sonList);
				}
			}
		}
		return map;
	} 
	
	public static void main(String[] args) {
	     BoardBizImpl bb=new BoardBizImpl();
	     Map<Integer,List<Board>> map=bb.findAllBoard();
	     System.out.println(map);
	     
	}
}
