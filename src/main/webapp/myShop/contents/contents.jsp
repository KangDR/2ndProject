<%@page import="java.net.URLEncoder"%>
<%@page import="my.Shop.CategoryBean"%>
<%@page import="my.Shop.CategoryDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.wiki.ArticleBean"%>
<%@page import="my.wiki.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path=request.getContextPath();
request.setCharacterEncoding("UTF-8");
String search=request.getParameter("search");
String version=request.getParameter("version");
if(version==null){
	version="0";
}
ArticleDao adao=ArticleDao.getInstance();
ArrayList<ArticleBean> list=adao.searchData(search,version);
CategoryDao cdao=CategoryDao.getInstance();
ArrayList<CategoryBean> clist=cdao.getAllCategory();
String cname=null;
if(list.size()!=0){
	for(CategoryBean cb:clist){
		if(cb.getCode().equals(list.get(0).getCode())){
			cname=cb.getCname();
		}
	}
}
if(list.size()!=0){
%>
<jsp:include page="../../top.jsp"/>
<div class="container">
<div class="Atitle">[<%=cname%>]<%=list.get(0).getTitle() %></div>
<div class="timestamp"><%=list.get(0).getReg_date() %></div>
<div align="right"><a href="history.jsp?title=<%=URLEncoder.encode(list.get(0).getTitle(),"UTF-8")%>">역사보기</a></div>
<div class="contents">
<%if(list.get(0).getImg()!=null){ %>
<img src='<%=request.getContextPath()+"/myShop/contents/img/"+list.get(0).getImg()%>'><br>
<%} %>
<%=list.get(0).getContents() %>
</div>
<%if(version.equals("0")){ %>
<div style="text-align: right;"><input type="button" value="수정하기" class="buttons" onclick="location.href='updateArticle.jsp?title=<%=URLEncoder.encode(list.get(0).getTitle(),"UTF-8")%>'"></div>
<%} %>
</div>
<jsp:include page="../../bottom.jsp"/>
<%}
else{%>
<jsp:include page="../../top.jsp"/>
<div class="container">
<div class="title">문서가 없습니다.</div>
<div class="contents"><a href="<%=request.getContextPath()%>/myShop/contents/CreateArticle.jsp">새 문서 만들기</a></div>
</div>
<jsp:include page="../../bottom.jsp"/>
<%}%>