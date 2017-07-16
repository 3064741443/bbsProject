<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.yc.biz.BoardBizImpl,com.yc.bean.Board,java.util.Map,java.util.List,com.yc.bean.Topic"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="logo.jsp" %>

<!--      主体        -->
<DIV class="t">
	<TABLE cellSpacing="0" cellPadding="0" width="100%">
		<TR class="tr2" align="center">
			<TD colSpan="2">论坛</TD>
			<TD style="WIDTH: 10%;">主题</TD>
			<TD style="WIDTH: 30%">最后发表</TD>
		</TR>
		
		<%
		    BoardBizImpl bbi=new BoardBizImpl();
			Map<Integer,List<Board>> map=bbi.findAllBoard();
			//取出键为0的子版块 列表
			List<Board> fatherBoards=map.get(0);
			if(fatherBoards!=null && fatherBoards.size()>0){
				for(Board fb:fatherBoards){
		%>
		
	<!--       主版块       -->
		
		<TR class="tr3">
			<TD colspan="4"><%=fb.getBoardname() %></TD>
		</TR>
		
		<%
		    if(map.get(fb.getBoardid())!=null){
		    	List<Board> sonBoardList=map.get(fb.getBoardid());
		    	for(Board b:sonBoardList){
		    
		%>
	<!--       子版块       -->
		
		<TR class="tr3">
			<TD width="5%">&nbsp;</TD>
			<TH align="left">
				<IMG src="image/board.gif">
				<A href="doList.jsp?boardid=<%=b.getBoardid()%>&pages=1"><%=b.getBoardname() %></A>
			</TH>
			<TD align="center"><%=b.getTotal() %></TD>
			
			<%
			   if(b.getTopic()!=null){
				   Topic t=b.getTopic();
			%>
			<TH>
				<SPAN><A href="doDetail.jsp?topicid=<%=t.getTopicid()%>&pages=1"><%=t.getTitle() %> </A>
				</SPAN><BR/><SPAN><%=t.getUname() %></SPAN><SPAN class="gray"><%=t.getModifytime() %></SPAN>
			</TH>
		
		
		<%
			   }else{
				   out.print("<th>暂无新帖<th/>");
			   }
		%>
		
		</TR>
		
		<%
		    	}
				}
				}
			}
		%>
 
 
 </TABLE>
 </DIV>
<%@ include file="bottom.jsp" %>
