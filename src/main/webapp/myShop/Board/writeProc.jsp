<%@page import="java.sql.Timestamp"%>
<%@page import="my.Board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bean" class="my.Board.BoardBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
Timestamp ts=new Timestamp(System.currentTimeMillis());
bean.setReg_date(ts);
bean.setIp(request.getRemoteAddr());
BoardDao bdao=BoardDao.getInstance();
int cnt=bdao.insertArticle(bean);
if(cnt>0){
	response.sendRedirect("list.jsp");
}
else{
%>
다시 시도
<%	
}
%>