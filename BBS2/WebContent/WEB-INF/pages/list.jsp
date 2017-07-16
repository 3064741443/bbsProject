<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.yc.bean.*,java.util.*" %>
 <%@ include file="../../logo.jsp" %>


<!--      新帖        -->
	<DIV>
		<A href="toPost.jsp"><IMG src="image/post.gif" name="td_post" border="0" id=td_post></A>
	</DIV>
<!--         翻 页         -->
	<DIV>
	
	    <%
	       //1.取出request中的pages，这是当前的页数
	       int pages=Integer.parseInt(request.getParameter("pages"));
	      //2 取出boardid
	      int boardid=Integer.parseInt(request.getParameter("boardid"));
	      
	      //3.上一页是？？？    下一页是？？
	      int pre=pages;
	      if(pages>1){
	    	  pre=pages-1;
	      }
	      
	      int next=pages+1;
	       
	      
	    %>
		<a href="doList.jsp?boardid=<%=boardid %>&pages=<%=pre %>">上一页</a>
		<a href="doList.jsp?boardid=<%=boardid %>&pages=<%=next %>">下一页</a>
	</DIV>

	<DIV class="t">
		<TABLE cellSpacing="0" cellPadding="0" width="100%">		
			<TR>
				<TH class="h" style="WIDTH: 100%" colSpan="4"><SPAN>&nbsp;</SPAN></TH>
			</TR>
<!--       表 头           -->
			<TR class="tr2">
				<TD>&nbsp;</TD>
				<TD style="WIDTH: 80%" align="center">文章</TD>
				<TD style="WIDTH: 10%" align="center">作者</TD>
				<TD style="WIDTH: 10%" align="center">回复</TD>
			</TR>
<!--         主 题 列 表        -->

        <%
		   //从session中取出topicList
		   List<Topic> list=(List<Topic>)session.getAttribute("topicList");
				if(list!=null&& list.size()>0){
					for(Topic t:list){
						System.out.println(t.getTitle());
						System.out.print(t.getUname());
		%>
			
			<TR class="tr3">
				<TD><IMG src="image/topic.gif" border=0></TD>                                       
				<TD style="FONT-SIZE: 15px">
					<A href="doDetail.jsp?topicid=<%=t.getTopicid()%>&pages=1"><%=t.getTitle() %></A>
				</TD>
				<TD align="center"><%=t.getUname() %></TD>       
				<TD align="center"><%=t.getNum() %></TD>
			</TR>
			
			<%
			       }
			   }
			%>
		
			
		</TABLE>
	</DIV>
<!--            翻 页          -->
	<DIV>
		<a href="doList.jsp?boardid=<%=boardid %>&pages=<%=pre %>">上一页</a>
		<a href="doList.jsp?boardid=<%=boardid %>&pages=<%=next %>">下一页</a>
	</DIV>
</DIV>

<%@ include file="../../bottom.jsp"%>

