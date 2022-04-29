<%@page import="my.wiki.ArticleBean"%>
<%@page import="my.wiki.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String search=request.getParameter("search");
ArticleDao adao=ArticleDao.getInstance();
ArticleBean ab=adao.searchData(search);
%>