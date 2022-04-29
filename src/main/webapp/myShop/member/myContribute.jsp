<%@page import="java.net.URLEncoder"%>
<%@page import="my.wiki.ArticleBean"%>
<%@page import="my.wiki.ArticleDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String writer=request.getParameter("writer");
ArrayList<ArticleBean> list=null;
if(writer!=null){
	ArticleDao adao=ArticleDao.getInstance();
	list=adao.searchWriter(writer);
} 
%>
<%@include file="../../top.jsp"%>
<style type="text/css">
th{
	background-color: #519d9e;
}
</style>
<div class="container">
<table border="1" style="margin-left: auto; margin-right: auto; padding-top: 20px; padding-bottom: 20px" width="610px">
			<tr class="m1">
				<td>no</td>
				<td>분류</td>
				<td>이미지</td>
				<td>위키명</td>
				<td>작성일자</td>
				<td>버전</td>
				<td>작성자</td>
			</tr>
			<%if(list==null||list.size()==0){ %>
			<tr><td colspan="7" style="text-align: center;">조회할 내역이 없습니다.</tr>
			<%} 
			else{
				for(ArticleBean ab:list){
			%>
			<tr>
				<td><%=ab.getNo()%></td>
				<td><a href='<%=request.getContextPath()+"/myShop/contents/articleBycate.jsp?category="+ab.getCode()+"&cname="+ab.getCode()%>'><%=ab.getCode()%></a></td>
				<td><%if(ab.getImg()==null||ab.getImg()=="null"){ %>
					이미지 없음
					<%}
					else{
					%>
					<img src='<%=request.getContextPath()+"/myShop/contents/img/"+ab.getImg()%>' width="100px" height="100px">
					<%} %></td>
				<td><a href='<%=request.getContextPath()+"/myShop/contents/contents.jsp?search="+URLEncoder.encode(ab.getTitle(), "UTF-8")+"&version="+ab.getVersion()%>''><%=ab.getTitle()%></a></td>
				<td><%=ab.getReg_date()%></td>
				<td><%=ab.getVersion()%></td>
				<td><%=ab.getWriter()%></td>
			</tr>
			<%}
			}
			%>
</table>
</div>
<%@include file="../../bottom.jsp"%>