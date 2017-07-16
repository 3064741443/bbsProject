<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.yc.bean.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<base href="<%=basePath%>">
<Link rel="stylesheet" type="text/css" href="style/style.css" />

</head>
<body>
       <DIV>
	<IMG src="image/logo.gif">
</DIV>
<!--      用户信息、登录、注册        -->
<script type="text/javascript" src="js/commonAjax.js"></script>

<script type="text/javascript">
       function logout(){
    	   doAjax(null, handleFunc, "doLogout.jsp");
       }
       
       function handleFunc(){
    	   switch(xmlHttp.readyState){	
    		case 4:
    			//alert("伺服端回應：" + xmlHttp.responseText); 
    	         if(xmlHttp.status == 200) {  
    	        	var obj= document.getElementById("logindiv");
    	        	obj.innerHTML="您尚未　<a href='login.jsp'>登录</a> &nbsp;| &nbsp; <A href='reg.jsp'>注册</A> | "
    			 }  
    	         break;
    		}
       }
       
</script>

<DIV id="logindiv" class="h">
    <%
        if(session.getAttribute("user")!=null){
        	User u=(User)session.getAttribute("user");
    %>
    欢迎你：<%=u.getUname() %> | <a href="javascript:void(0)" onclick="logout()">退出</a>
    
    <%
        }else{
    %>
	您尚未　<a href="login.jsp">登录</a>
	&nbsp;| &nbsp; <A href="reg.jsp">注册</A> |
	
	<%
        }
	%>
</DIV>
<!--      主体        -->
<DIV>
<!--      导航        -->
<br/>
<DIV>
	&gt;&gt;<B><a href="index.jsp">论坛首页</a></B>&gt;&gt;

</DIV>
<br/>

</body>
</html>