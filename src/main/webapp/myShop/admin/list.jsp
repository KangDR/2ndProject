<%@page import="java.net.URLEncoder"%>
<%@page import="my.wiki.ArticleBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.wiki.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="top.jsp"%>
<%
ArticleDao adao=ArticleDao.getInstance();
ArrayList<ArticleBean> list=adao.recentChanged();
System.out.print(list.size());
%>
<style type="text/css">
th{
	background-color: #519d9e;
}
</style>
<td colspan="6" align="center">
<table border='1' style="width: 600px;">
	<tr>
		<th>no</th>
		<th>분류</th>
		<th>제목</th>
		<th>작성자</th>
		<th>이미지</th>
		<th>작성일자</th>
		<th>삭제</th>
	</tr>
	<%if(list.size()==0){ %>
	<tr><td colspan="7">데이터가 없습니다.</td></tr>
	<%} 
	else{
	for(ArticleBean ab:list){
	%>
	<tr>
	<td><%=ab.getNo()%></td>
	<td><%=ab.getCname() %></td>
	<td><a href='<%=request.getContextPath()+"/myShop/contents/contents.jsp?search="%><%=ab.getTitle()%>'><%=ab.getTitle() %></a></td>
	<td><%=ab.getWriter() %></td>
	<td>
	<%if(ab.getImg()==null){ %>
	이미지 없음
	<%}
	else{
	%>
	<img src='<%=request.getContextPath()+"/myShop/contents/img/"+ab.getImg()%>' width="100px" height="100px">
	<%} %>
	</td>
	<td><%=ab.getReg_date()%></td>
	<td><a href="deleteArticle.jsp?title=<%=URLEncoder.encode(ab.getTitle(), "UTF-8")%>&img=<%=ab.getImg()%>">삭제</a></td>
	</tr>
	<%
		}
	}
	%>
</table>
</td>
<%@ include file="bottom.jsp"%>