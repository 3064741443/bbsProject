<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="com.yc.bean.*,com.yc.biz.*,java.util.*"%>
<%
   int replyid=Integer.parseInt(request.getParameter("replyid"));
   //从session中取出replyList查replyid
   List<Reply> replyList=(List<Reply>)session.getAttribute("replyList");
   for(Reply t:replyList){
	   if(t.getReplyid()==replyid){
		   session.setAttribute("toModifyReply", t);
	   }
   }
   request.getRequestDispatcher("WEB-INF/pages/modify.jsp").forward(request, response);
   
   
%>