<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="com.yc.bean.*,com.yc.biz.*,java.util.*"%>
<%
   int replyid=Integer.parseInt(request.getParameter("replyid"));
   ReplyBizImpl rbi=new ReplyBizImpl();
   rbi.delReply(replyid);
   
   Topic topic=(Topic)session.getAttribute("toShowTopic");
   response.sendRedirect("doDetail.jsp?topicid="+topic.getTopicid()+"&pages=1");
   
%>