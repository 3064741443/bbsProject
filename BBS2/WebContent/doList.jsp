<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.yc.bean.*,com.yc.biz.*,java.util.List"%>
<Link rel="stylesheet" type="text/css" href="style/style.css" />
<%
    //取出板块编号查询
    int boardid=Integer.parseInt(request.getParameter("boardid"));
    
    //将boardid存到session中，以备;后面使用
    session.setAttribute("boardid", boardid);
 
    //分页参数
    //如果没有传页数，则是第一页
    int pages=1;
    if(request.getParameter("pages")!=null){
        pages=Integer.parseInt(request.getParameter("pages"));
        
    }
    
    int pagesize=20;  //每页最多显示几条数据
    if(request.getParameter("pagesize")!=null){
    	pagesize=Integer.parseInt(request.getParameter("pagesize"));
        
    }
    TopicBizImpl tbi=new TopicBizImpl();
    List<Topic> list=tbi.findTopicByBoard(boardid,pages,pagesize);
    
    //将查出来的boardid版块下 pages页下所有的topic list数据存到session中，以备以后查看详情做准备
    //为什么呢   因为session是一次会话，只要不关闭浏览器，则这个数据一直都在内存了
    session.setAttribute("topicList", list);
    
    //跳转页面到list.jsp页上做显示
    //response.sendRedirect("list.jsp");
    request.getRequestDispatcher("/WEB-INF/pages/list.jsp").forward(request, response);
     System.out.println(list);
%>