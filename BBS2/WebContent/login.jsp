<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="logo.jsp"%>    

<!--      用户登录表单        -->
<DIV class="t" style="MARGIN-TOP: 15px" align="center"	>
	<FORM name="loginForm" action="doLogin.jsp" method="post">
		<br/><br/>用户名 &nbsp;<INPUT class="input" tabIndex="1"  type="text"      maxLength="20" size="35" name="uname">
		<br/><br/>密　码 &nbsp;<INPUT class="input" tabIndex="2"  type="password"  maxLength="20" size="40" name="upass">
		<br/><br/>验证码&nbsp;<INPUT type="text" name="valCode" class="input" tabIndex="3" maxLength="4" size="20"/>
		<br/><br/><img id="img" src="image.jsp" width="70" height="30"/><a href="javascript:void(0)" onclick="showAgain()">看不清</a>
		 
		<br/><INPUT class="btn"  tabIndex="6"  type="submit" value="登 录">
	</FORM>
</DIV>

<<script type="text/javascript">
      function showAgain(){
    	  document.getElementById("img").src="image.jsp?"+new Date();
      }
</script>

<%@ include file="bottom.jsp"%>