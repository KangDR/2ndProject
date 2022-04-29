<%@page import="java.net.URLEncoder"%>
<%@page import="my.wiki.ArticleBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.wiki.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%@ include file="../../top.jsp" %>
<table border='1' style="width: 500px;margin-left: auto; margin-right: auto; padding-top: 20px; padding-bottom: 20px">
	<tr>
		<th>no</th>
		<th>분류</th>
		<th>제목</th>
		<th>작성자</th>
		<th>이미지</th>
		<th>작성일자</th>
	</tr>
	<%if(list.size()==0){ %>
	<tr><td colspan="6">데이터가 없습니다.</td></tr>
	<%} 
	else{
	for(ArticleBean ab:list){
	%>
	<tr>
	<td><%=ab.getNo()%></td>
	<td><%=ab.getCname() %></td>
	<td><a href='<%=request.getContextPath()+"/myShop/contents/contents.jsp?search="%><%=URLEncoder.encode(ab.getTitle(),"UTF-8")%>'><%=ab.getTitle() %></a></td>
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
	</tr>
	<%
		}
	}
	%>
</table>
<%@ include file="../../bottom.jsp" %>