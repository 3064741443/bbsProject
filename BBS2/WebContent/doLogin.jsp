
<%@page import="com.yc.biz.UserBiz"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.yc.bean.*,com.yc.util.*"%>

<%

     //设置编码
     request.setCharacterEncoding("utf-8");
     //2.取出参数
     //String uname=request.getParameter("uname");
     //String upass=request.getParameter("upass");
    
     //封装取参的代码
     //局限：只取单参数 uname ,upass,String[]不管                     优点，处理类型
     User user= RequestUtil.getParameter(request, User.class);
     String valCode=request.getParameter("valCode"); //用户输入的验证码 ，request.getparameter(),根据name获取相应的值

     //取出sessio中的rand
     String rand=session.getAttribute("rand").toString();
     if(!valCode.equals(rand)){
    	 out.print("<script>alert('验证码错误');location.href='login.jsp';</script>");
    	 return ;
     }
     //完成登录，权限控制 session
     UserBiz ub=new UserBiz();
     user=ub.login(user);
     
     if(user==null){
    	 out.print("<script>alert('登录失败');location.href='login.jsp';</script>");
     }else{
    	 session.setAttribute("user", user);
    	 out.print("<script>alert('登录成功');location.href='index.jsp';</script>");
     }
     System.out.println(user);
%>

