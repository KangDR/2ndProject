<%@page import="java.text.SimpleDateFormat"%>
<%@page import="my.Board.BoardDao"%>
<%@page import="my.Board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
body{
	text-align: center;
}
table{
margin:auto;
}
.m2{
	background-color: gray;
}
</style>
<%
String pageNum=request.getParameter("pageNum");
if(pageNum==null){
	pageNum="1";
}
int pageSize=5;
int currentPage=Integer.parseInt(pageNum);
int startRow=(currentPage-1)*pageSize+1;
int endRow=currentPage*pageSize;

ArrayList<BoardBean> list=new ArrayList<BoardBean>();
BoardDao bdao=BoardDao.getInstance();
int count=bdao.getArticleCount();
int number=count-(currentPage-1)*pageSize;
list=bdao.getArticles(startRow,endRow);
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%@include file="../../top.jsp" %>
<%=request.getContextPath()%>
<br>
<%=startRow%>
<%=endRow%>
<%=number%>
글목록(전체 글:<%=count%>)<br>
<table width="700" border="1">
	<tr>
		<th style="background-color: black;" align="right"><a href="writeForm.jsp">글쓰기</a></th>
	</tr>
</table>
<table width="700" border="1">
	<tr class="m1">
		<th align="center">번호</th>
		<th align="center">제목</th>
		<th align="center">작성자</th>
		<th align="center">작성일</th>
		<th align="center">조회</th>
		<th align="center">IP</th>
	</tr>
	<%
		for(int i=0;i<list.size();i++){
			BoardBean article =list.get(i);
	%>
		<tr class="m2">
			<td align="center"><%=number-- %></td>
			<td>
			<%if(article.getRe_level()>0){%>
				<img src="../../images/level.gif" width="<%=article.getRe_level()*20 %>" height="15" >
				<img src="../../images/re.gif" >
			<%}%>
			<a href="contents.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>"><%=article.getSubject() %></a>
			<%if(article.getReadcount()>=10){%>
				<img src="../../images/hot.gif" >
			<%}%>
			</td>
			<td align="center"><%=article.getWriter() %></td>
			<td align="center"><%=sdf.format(article.getReg_date()) %></td>
			<td align="center"><%=article.getReadcount() %></td>
			<td align="center"><%=article.getIp() %></td>
		</tr>
	<%
		}
	%>
</table>
<%
	if(count>0){
		int pageCount=count/pageSize+(count%pageSize==0?0:1);//페이지 개수
		int pageBlock=5;
		int startPage=((currentPage-1)/pageBlock*pageBlock)+1;;
		int endPage=startPage+pageBlock-1;
		if(endPage>pageCount){
			endPage=pageCount;
		}
		if(startPage>5){
			%>
			<a href="list.jsp?pageNum=<%=startPage-10%>">[이전]</a>
			<%	
			}
			for(int i=startPage;i<=endPage;i++){
			%>
			<a href="list.jsp?pageNum=<%=i%>">[<%=i%>]</a>
			<%	
			}
			if(endPage<pageCount){
			%>
			<a href="list.jsp?pageNum=<%=startPage+10%>">[다음]</a>
			<%
			}
	}
%>
<%@include file="../../bottom.jsp" %>