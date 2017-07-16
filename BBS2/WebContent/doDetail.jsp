<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.yc.bean.*,com.yc.biz.*,java.util.*"%>
<Link rel="stylesheet" type="text/css" href="style/style.css" />
<%
    //取出板块编号查询
    int topicid=Integer.parseInt(request.getParameter("topicid"));
    /* 
     if(session.getAttribute("topicList")!=null){
     List<Topic> topicList=(List<Topic>)session.getAttribute("topicList");
     for(Topic t:topicList){
    	 if(t.getTopicid()==topicid){
    		 session.setAttribute("toShowTopic", t); 
    		 //查这个topic对应的用户信息
    		 UserBiz ub=new UserBiz();
    		 User topicUser=ub.findUserById(t.getId());
    		 session.setAttribute("topicUser", topicUser);
    		 session.setAttribute("toShowTopic", t);
    		 break;
    	 }
     }
   }else{ */
	   TopicBizImpl tbi=new TopicBizImpl();
	   Topic t=tbi.findTopicById(topicid);
	   UserBiz ub=new UserBiz();
       User topicUser=ub.findUserById(t.getId());
	   session.setAttribute("topicUser", topicUser);
	   session.setAttribute("toShowTopic", t);
 //  }
    //分页参数
    //如果没有传页数，则是第一页
    int pages=1;
    if(request.getParameter("pages")!=null){
        pages=Integer.parseInt(request.getParameter("pages"));
        
    }
    
    int pagesize=5;  //每页最多显示几条数据
    if(request.getParameter("pagesize")!=null){
    	pagesize=Integer.parseInt(request.getParameter("pagesize"));
        
    }
    ReplyBizImpl rbi=new ReplyBizImpl();
    List<Reply> list=rbi.findReplyByTopic(topicid, pages, pagesize);
    
    //将查出来的boardid版块下 pages页下所有的topic list数据存到session中，以备以后查看详情做准备
    //为什么呢   因为session是一次会话，只要不关闭浏览器，则这个数据一直都在内存了
    session.setAttribute("replyList", list);
    
    //跳转页面到list.jsp页上做显示
// response.sendRedirect("/WEB-INF/pages/detail.jsp");
    
    request.getRequestDispatcher("/WEB-INF/pages/detail.jsp").forward(request, response);
     System.out.println(list);
%>