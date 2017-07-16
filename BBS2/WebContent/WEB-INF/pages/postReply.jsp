<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../logo.jsp" %>

<form action="doPostReply.jsp" method="post">
     回复的标题：<input type="" name="title" /><br>
     回复的内容：<script id="container" name="content" type="text/plain">
      请输入话题内容,长度不超过1000字...
     </script>
   <br/>
  <input type="submit" value="发表回复" />
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