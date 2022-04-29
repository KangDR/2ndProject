<%@page import="java.net.URLEncoder"%>
<%@page import="my.wiki.ArticleBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.wiki.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String title=request.getParameter("title");
ArticleDao adao=ArticleDao.getInstance();
ArrayList<ArticleBean> list=adao.getHistory(title);
%>
<jsp:include page="../../top.jsp"/>
<div class="container">
<div class="Atitle"><%=list.get(0).getTitle()%>[문서 역사]</div>
<ul>
	<%for(ArticleBean ab:list){ %>
	<li>작성시간:[<%=ab.getReg_date()%>] 버전:[<%=ab.getVersion()%>] 작성자:[<%=ab.getWriter()%>]<a href="contents.jsp?search=<%=URLEncoder.encode(ab.getTitle(),"UTF-8")%>&version=<%=ab.getVersion()%>">보기</a></li>
	<%} %>
</ul>
</div>
<jsp:include page="../../bottom.jsp"/>