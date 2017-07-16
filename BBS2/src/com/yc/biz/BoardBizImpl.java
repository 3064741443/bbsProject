package com.yc.biz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.yc.bean.Topic;
import com.yc.bean.Board;
import com.yc.dao.DBHelper;

//������дҵ���     �൱��ҵ��bean

public class BoardBizImpl{
	private DBHelper db=new DBHelper();
	/**
	 * �������еİ�鼰ÿ�������Ϣ
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
				//ȡ��b�е�parentid,��map���ж��Ƿ������������ţ����� map.containKey()
				// ���û�����������b�е�parentid ���ɼ��������ٴ���һ��list<Board> ,����ǰ���b�浽list�У��ٽ�list�浽map��
				//��������������map�и���parentid ȡ��ֵList<Board> ,��b�浽���list����
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
