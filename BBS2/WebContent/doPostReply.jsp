<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.yc.bean.*,com.yc.util.*,com.yc.biz.*"%>
<% 
   request.setCharacterEncoding("utf-8");
  // String title=request.getParameter("title");
   //String content=request.getParameter("content");
 Reply reply=RequestUtil.getParameter(request, Reply.class);
   
   User user=(User)session.getAttribute("user");
   int id=user.getId();
   
   Topic toShowTopic=(Topic)session.getAttribute("toShowTopic");
   int topicid=toShowTopic.getTopicid();
   reply.setId(id);
   reply.setTopicid(topicid);
   
   ReplyBizImpl tbi=new ReplyBizImpl();
   tbi.addReply(reply);
   response.sendRedirect("doDetail.jsp?topicid="+topicid+"&pages=1");
   //request.getRequestDispatcher("doList.jsp?boardid="+boardid+"&pages=1").forward(request, response);
   //以上使用转发，后果很严重
   //System.out.println(topic.getTitle()+" "+topic.getContent()+" "+" "+id+" "+" "+boardid);
   
%>