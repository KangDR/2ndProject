<%@page import="java.net.URLEncoder"%>
<%@page import="my.wiki.ArticleBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.wiki.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String code=request.getParameter("category");
String cname=request.getParameter("cname");
ArticleDao adao=ArticleDao.getInstance();
ArrayList<ArticleBean> list=adao.selectByCode(code);
%>
<style type="text/css">
th{
	background-color: #519d9e;
}
</style>
<jsp:include page="../../top.jsp"/>
<div style="padding-left: 20%;padding-right: 20%">
	<table style="margin-left: auto; margin-right: auto; padding-top: 20px; padding-bottom: 20px">
		<tr><td style="text-align: center;" colspan="5" bgcolor="#008275"><strong><%=cname %></strong></td></tr>
		<tr>
			<th>분류</th>
			<th>제목</th>
			<th>작성자</th>
			<th>이미지</th>
			<th>작성일자</th>
		</tr>
		<%if(list.size()==0){ %>
	<tr><td colspan="5" style="text-align: center;">데이터가 없습니다.</td></tr>
	<%} 
	else{
	for(ArticleBean ab:list){
	%>
	<tr>
	<td><%=cname %></td>
	<td><a href='<%=request.getContextPath()+"/myShop/contents/contents.jsp?search="%><%=URLEncoder.encode(ab.getTitle(), "UTF-8")%>'><%=ab.getTitle() %></a></td>
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
</div>
<jsp:include page="../../bottom.jsp"/>