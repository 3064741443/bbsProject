<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //判断当前用户是否登录了，没有登录，则先登录，才能发表
    if(session.getAttribute("user")==null){
    	out.print("<script>alert('请先登录，才能发表回复...');location.href='login.jsp'</script>");
    }else{
    	request.getRequestDispatcher("/WEB-INF/pages/postReply.jsp").forward(request, response);
    }
   
%> 