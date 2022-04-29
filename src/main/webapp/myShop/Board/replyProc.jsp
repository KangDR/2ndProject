<%@page import="my.Board.BoardDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
replyproc.jsp<br>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bb" class="my.Board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>
<%
Timestamp ts=new Timestamp(System.currentTimeMillis());
bb.setReg_date(ts);
bb.setIp(request.getRemoteAddr());
BoardDao bdao=BoardDao.getInstance();
int cnt=bdao.replyArticle(bb);
if(cnt>0){
	response.sendRedirect("list.jsp");
}
%>