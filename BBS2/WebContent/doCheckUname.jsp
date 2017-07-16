<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.yc.biz.*"%>

<%
    String uname=request.getParameter("uname");
    System.out.println(uname);
    UserBiz ub=new UserBiz();
    boolean r=ub.findUserByUname(uname);
    if(r){
    	out.print("1");
    }else{
    	out.print("0");
    }
%>