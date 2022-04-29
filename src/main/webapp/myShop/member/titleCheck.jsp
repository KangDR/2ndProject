<%@page import="my.wiki.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String title=request.getParameter("title");
ArticleDao adao=ArticleDao.getInstance();
boolean flag=false;
flag=adao.titleCheck(title);
if(flag==true){
	out.write("YES");
}
else{
	out.write("NO");
}
%>