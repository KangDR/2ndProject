<%@page import="java.net.URLEncoder"%>
<%@page import="my.Shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.Shop.CategoryDao"%>
<%@page import="my.wiki.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArticleDao adao=ArticleDao.getInstance();
int cntArticle=adao.countArticle();
CategoryDao cdao=CategoryDao.getInstance();
int cntCategory=cdao.countCategory();
ArrayList<CategoryBean> list=cdao.getAllCategory(); 
%>
<%@ include file="top.jsp"%>
<div class="contents">
<div style="padding-left: 30%; padding-right: 30%"><h3>중앙위키</h3><br>
현재 카테고리의 개수는 <%=cntCategory%>개이며<br>
총 <%=cntArticle%>개의 문서가 작성되어 있습니다.<br>
<br>
<h3>분류별로 보기</h3>
<table>
<tr>
<%
for(CategoryBean cb:list){
%>	
<td><a href="<%=conPath%>/myShop/contents/articleBycate.jsp?category=<%=cb.getCode()%>&cname=<%=URLEncoder.encode(cb.getCname(), "UTF-8")%>"><%=cb.getCname()%></a></td>
<%} %>
</tr>
</table>
</div>
</div>
<%@ include file="bottom.jsp"%>