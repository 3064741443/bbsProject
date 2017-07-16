<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.yc.bean.*"%>
<%@ include file="../../logo.jsp" %>

<%
   Reply r=(Reply) session.getAttribute("toModifyReply");
%>

<form action="doModifyReply.jsp" method="post">
<input type="hidden" name="replyid" value="<%=request.getParameter("replyid")%>"/>
     修改回复的标题：<input type="" name="title" value=="<%=r.getTitle() %>"/><br>
    修改 回复的内容：<script id="container" name="content" type="text/plain">
       <%=r.getContent()%>
     </script>
   <br/>
  <input type="submit" value="修改回复" />
</form>

<!-- 配置文件  -->
<script type="text/javascript" src="utf8-jsp/ueditor.config.js"> </script>
<!--编辑器源码文件  -->
<script type="text/javascript" src="utf8-jsp/ueditor.all.js"> </script>

<!-- 实例化编辑器-->
<script type="text/javascript"> 
       var ue=UE.getEditor("container");
</script>
<%@ include file="../../bottom.jsp"%>