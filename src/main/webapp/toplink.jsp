<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String search=request.getParameter("search");
String search2=URLEncoder.encode(search,"UTF-8");
response.sendRedirect("./myShop/contents/contents.jsp?search="+search2);
%>