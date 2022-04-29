<%@page import="my.Board.BoardBean"%>
<%@page import="my.Board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String number=request.getParameter("num");
int num=Integer.parseInt(number);
BoardDao bdao=BoardDao.getInstance();
BoardBean bb=bdao.oneSelect(num);
String pageNum=request.getParameter("pageNum");
System.out.println(pageNum);
%>
<%@include file="../../top.jsp" %>
<form method="post" action="deleteProc.jsp">
<input type="hidden" name="num" value=<%=num %>>
<input type="hidden" name="pageNum" value=<%=pageNum %>>
	<table border="1" align="center">
		<tr>
			<td bgcolor="#09AD35">
				비밀번호를 입력하세요
			</td>
		</tr>
		<tr>
			<td bgcolor="#BFBFBF">
				비밀번호:<input type="password" name="passwd">
			</td>
		</tr>
		<tr>
			<td bgcolor="black">
				<input type="submit" value="글삭제">
				<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">
			</td>
		</tr>
	</table>
</form>
<%@include file="../../bottom.jsp" %>