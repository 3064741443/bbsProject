<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="logo.jsp"%>

<<script type="text/javascript" src=js/commonAjax.js>
<!--

//-->
</script>
<script type="text/javascript">

function checkUname(uname){
	var queryString="uname="+uname;
	doAjax(queryString,handleStateChange,"doCheckUname.jsp");
	xmlHttp.open("post","doCheckUname.jsp",true);
	xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); //传递参数的编码方式
	xmlHttp.send(queryString); //发送请求

}

function handleStateChange() { 
	switch(xmlHttp.readyState){	
	case 4:
		//alert("伺服端回應：" + xmlHttp.responseText); 
         if(xmlHttp.status == 200) {  
        	 if(xmlHttp.responseText==1){
        		 var obj=document.getElementById("unamediv");
        		 obj.innerHTML=" <font color='red'>用戶名已存在</font>";
        		 obj.style.display="inline";
        	 }else{
        		 obj.innerHTML="";
        		 obj.style.display="none";
        	 }
		     //alert("伺服端回應：" + xmlHttp.responseText); 
		 }  
         break;
	}
}
</script>

<!--      用户注册表单        -->
<DIV  class="t" style="MARGIN-TOP: 15px" align="center">
	<FORM name="regForm" action="doReg.jsp" method="post">
		<br/>用&nbsp;户&nbsp;名 &nbsp;
			<INPUT class="input" tabIndex="1" type="text" maxLength="20" size="35" name="uname" onblur="checkUname(this.value)">
		   
		   <div id="unamediv" style="display:none"></div>	
		 
		<br/>密&nbsp;&nbsp;&nbsp;&nbsp;码 &nbsp;
			<INPUT class="input" tabIndex="2" type="password" maxLength="20" size="40" name="upass">
		<br/>重复密码 &nbsp;
			<INPUT class="input" tabIndex="3" type="password" maxLength="20" size="40" name="upass1">
		<br/>性别 &nbsp;
			女<input type="radio" name="gender" value="1">
			男<input type="radio" name="gender" value="2" checked="checked" />
		<br/>请选择头像 <br/>
		<image src="image/head/1.gif"/><input type="radio" name="head" value="1.gif" checked="checked">
		<img src="image/head/2.gif"/><input type="radio" name="head" value="2.gif">
		<img src="image/head/3.gif"/><input type="radio" name="head" value="3.gif">
		<img src="image/head/4.gif"/><input type="radio" name="head" value="4.gif">
		<img src="image/head/5.gif"/><input type="radio" name="head" value="5.gif">
		<BR/>
		<img src="image/head/6.gif"/><input type="radio" name="head" value="6.gif">
		<img src="image/head/7.gif"/><input type="radio" name="head" value="7.gif">
		<img src="image/head/8.gif"/><input type="radio" name="head" value="8.gif">
		<img src="image/head/9.gif"/><input type="radio" name="head" value="9.gif">
		<img src="image/head/10.gif"/><input type="radio" name="head" value="10.gif">
		<BR/>
		<img src="image/head/11.gif"/><input type="radio" name="head" value="11.gif">
		<img src="image/head/12.gif"/><input type="radio" name="head" value="12.gif">
		<img src="image/head/13.gif"/><input type="radio" name="head" value="13.gif">
		<img src="image/head/14.gif"/><input type="radio" name="head" value="14.gif">
		<img src="image/head/15.gif"/><input type="radio" name="head" value="15.gif">
		<br/>
			<INPUT class="btn" tabIndex="4" type="submit" value="注 册">
	</FORM>
</DIV>
<%@ include file="bottom.jsp"%>