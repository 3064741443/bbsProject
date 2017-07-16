
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.yc.bean.*,com.yc.util.*,com.yc.biz.UserBiz"%>

<%
     //设置编码
     request.setCharacterEncoding("utf-8");
     //2.取出参数
     //String uname=request.getParameter("uname");
     //String upass=request.getParameter("upass");
    
     //封装取参的代码
     //局限：只取单参数 uname ,upass,String[]不管                     优点，处理类型
     User user= RequestUtil.getParameter(request, User.class);
    UserBiz ub=new UserBiz();
     try{
     ub.reg(user);
     out.print("<script>alert('注册成功');location.href='login.jsp';</script>");
     }catch(Exception ex){
      out.print("<script>alert('"+ex.getMessage()+"');location.href='login.jsp';</script>"); 
     }     
     System.out.println(user);
%>