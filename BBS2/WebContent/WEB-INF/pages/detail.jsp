<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="com.yc.bean.*,com.yc.biz.*,java.util.List"%>   
    
<%@ include file="../../logo.jsp" %>

	<!--      回复、新帖        -->
	<DIV>
		<A href="toPostReply.jsp"><IMG src="image/reply.gif"  border="0" id=td_post></A> 
		<A href="toPost.jsp"><IMG src="image/post.gif"   border="0" id=td_post></A>
	</DIV>
	<!--         翻 页         -->
	<DIV>
	
	    <%
	      //1.取出request中的pages，这是当前页数
	      int pages=Integer.parseInt(request.getParameter("pages"));
	      int topicid=Integer.parseInt(request.getParameter("topicid"));
	      int pre=pages;
	      if(pages>1){
	    	  pre=pages-1;
	      }
	      int next=pages+1;
	      
	    %>
		<a href="doDetail.jsp?topicid=<%=topicid%>&pages=<%=pre%>">上一页</a>
		<a href="doDetail.jsp?topicid=<%=topicid%>&pages=<%=next%>">下一页</a>
	</DIV>
	<!--      本页主题的标题        -->
	
	<%
	    //从session.getAttribute取出topic，显示即可
	   Topic toShowTopic=(Topic) session.getAttribute("toShowTopic");
	   User topicUser=(User)session.getAttribute("topicUser");
	%>
	<DIV>
		<TABLE cellSpacing="0" cellPadding="0" width="100%">
			<TR>
				<TH class="h">本页主题:<%=toShowTopic.getTitle() %></TH>
			</TR>
			<TR class="tr2">
				<TD>&nbsp;</TD>
			</TR>
		</TABLE>
	</DIV>
	
	<!--      主题        -->
	
	<DIV class="t">
		<TABLE style="BORDER-TOP-WIDTH: 0px; TABLE-LAYOUT: fixed" cellSpacing="0" cellPadding="0" width="100%">
			<TR class="tr1">
				<TH style="WIDTH: 20%">
					<B><%=toShowTopic.getUname() %></B><BR/>
					<image src="image/head/<%=topicUser.getHead()%>"/><BR/>
					注册:<%=topicUser.getRegtime() %><BR/>
				</TH>
				<TH>
					<H4><%=toShowTopic.getTitle()%></H4>
					<DIV><%=toShowTopic.getContent() %></DIV>
					<DIV class="tipad gray">
						发表：[<%=toShowTopic.getPublishtime()%>] &nbsp;
						最后修改:[<%=toShowTopic.getModifytime()%>]
					</DIV>
				</TH>
			</TR>
		</TABLE>
	</DIV>
	
	<!--      回复        -->
	
	<%
	   //从session中取出 replyList
	   List<Reply> list=(List<Reply>)session.getAttribute("replyList");
	   if(list!=null && list.size()>0){
		   for(Reply r:list){
	%>
	<DIV class="t">
		<TABLE style="BORDER-TOP-WIDTH: 0px; TABLE-LAYOUT: fixed" cellSpacing="0" cellPadding="0" width="100%">
			<TR class="tr1">
				<TH style="WIDTH: 20%">
					<B><%=r.getUname() %></B><BR/><BR/>
					<image src="image/head/<%=r.getHead()%>"/><BR/>
					注册:<%=r.getRegtime() %><BR/>
				</TH>
				<TH>
					<H4><%=r.getTitle() %></H4>
					<DIV><%=r.getContent() %></DIV>
					<DIV class="tipad gray">
						发表：[<%=r.getPublishtime() %>] &nbsp;
						最后修改:[<%=r.getModifytime() %>]
						<%
						  if(session.getAttribute("user")!=null){
						  User user=(User)session.getAttribute("user");
						if(user.getId()==r.getId()){
						%>
						<A href="doDel.jsp?replyid=<%=r.getReplyid()%>">[删除]</A>
						<A href="doModify.jsp?replyid=<%=r.getReplyid() %>">[修改]</A>
					</DIV>
					
					<%
						}
						}
					%>
				</TH>
			</TR>
		</TABLE>
		<%
	   }
	   }
		%>
	</DIV>
	
	
	
</DIV>
<%@ include file="../../bottom.jsp"%>

