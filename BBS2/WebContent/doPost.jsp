<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.yc.bean.*,com.yc.util.*,com.yc.biz.*"%>
<% 
   request.setCharacterEncoding("utf-8");
  // String title=request.getParameter("title");
   //String content=request.getParameter("content");
   Topic topic=RequestUtil.getParameter(request, Topic.class);
   
   User user=(User)session.getAttribute("user");
   int id=user.getId();
   
   int boardid=(Integer)session.getAttribute("boardid");
   topic.setId(id);
   topic.setBoardid(boardid);
   
   TopicBizImpl tbi=new TopicBizImpl();
   tbi.addTopic(topic);
   response.sendRedirect("doList.jsp?boardid="+boardid+"&pages=1");
   //request.getRequestDispatcher("doList.jsp?boardid="+boardid+"&pages=1").forward(request, response);
   //以上使用转发，后果很严重
   //System.out.println(topic.getTitle()+" "+topic.getContent()+" "+" "+id+" "+" "+boardid);
   
%>