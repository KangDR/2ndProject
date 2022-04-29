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
<jsp:include page="top.jsp" />
	<td colspan="6" align="center" valign="top">
		<table border="1">
			<tr>
				<th colspan="7" align="center">
					<form action="wikilist_member.jsp">
						조회할 위키 작성자:<input type="text" name="writer">
						<input type="submit" value="내역조회">
					</form>
				</th>
			</tr>
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
				<td><%if(ab.getImg()==null){ %>
					이미지 없음
					<%}
					else{
					%>
					<img src='<%=request.getContextPath()+"/myShop/contents/img/"+ab.getImg()%>' width="100px" height="100px">
					<%} %></td>
				<td><a href='<%=request.getContextPath()+"/myShop/contents/contents.jsp?search="+ab.getTitle()+"&version="+ab.getVersion()%>''><%=ab.getTitle()%></a></td>
				<td><%=ab.getReg_date()%></td>
				<td><%=ab.getVersion()%></td>
				<td><%=ab.getWriter()%></td>
			</tr>
			<%}
			}
			%>
		</table>
	</td>
<%@include file="bottom.jsp"%>