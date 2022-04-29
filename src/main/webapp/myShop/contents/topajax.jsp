<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList, my.wiki.ArticleDao"%>
<%
request.setCharacterEncoding("UTF-8");
ArticleDao adao=ArticleDao.getInstance();
String search=request.getParameter("search");
ArrayList<String> list=adao.autoComplete(search);
if(list.size()!=0){
	out.print(list);
}
%>