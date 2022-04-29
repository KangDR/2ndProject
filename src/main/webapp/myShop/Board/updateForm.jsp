<%@page import="java.text.SimpleDateFormat"%>
<%@page import="my.Board.BoardBean"%>
<%@page import="my.Board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript">
function check(){
	if($('input[name=writer]').val()==""){
		alert('작성자를 입력하세요');
		$('input[name=writer]').focus();
		return false;
	}
	if($('input[name=subject]').val()==""){
		alert('제목을 입력하세요');
		$('input[name=writer]').focus();
		return false;
	}
	if($('textarea[name=content]').val()==""){
		alert('내용 입력하세요');
		$('textarea[name=content]').focus();
		return false;
	}
	if($('input[name=passwd]').val()==""){
		alert('비밀번호를 입력하세요');
		$('input[name=passwd]').focus();
		return false;
	}
}
</script>
<%
request.setCharacterEncoding("UTF-8");
String number=request.getParameter("num");
int num=Integer.parseInt(number);
BoardDao bdao=BoardDao.getInstance();
BoardBean bb=bdao.oneSelect(num);
String pageNum=request.getParameter("pageNum");
%>
<%@include file="../../top.jsp" %>
<form method="post" action="updateProc.jsp" onsubmit="return check()">
<input type="hidden" name="num" value=<%=bb.getNum()%>>
<input type="hidden" name="pageNum" value=<%=pageNum%>>
<table border="1" style="margin: auto;">
	<tr>
		<td colspan="2" align="right" bgcolor="black"><a href="list.jsp">글목록</a></td>
	</tr>
	<tr>
		<td align="center" bgcolor="#09AD35">이름</td>
		<td bgcolor="#BFBFBF"><input type="text" name="writer" value="<%=bb.getWriter()%>"></td>
	</tr>
	<tr>
		<td align="center" bgcolor="#09AD35">제목</td>
		<td bgcolor="#BFBFBF"><input type="text" name="subject" value="<%=bb.getSubject()%>"></td>
	</tr>
	<tr>
		<td align="center" bgcolor="#09AD35">Email</td>
		<td bgcolor="#BFBFBF"><input type="text" name="email" value="<%=bb.getEmail()%>"></td>
	</tr>
	<tr>
		<td align="center" bgcolor="#09AD35">내용</td>
		<td bgcolor="#BFBFBF"><textarea cols="50" rows="20" name="content"><%=bb.getContent()%></textarea></td>
	</tr>
	<tr>
		<td align="center" bgcolor="#09AD35">비밀번호</td>
		<td bgcolor="#BFBFBF"><input type="password" name="passwd" value="<%=bb.getPasswd()%>"></td>
	</tr>
	<tr>
		<td colspan="2" align="center" bgcolor="black">
		<input type="submit" value="글쓰기" onclick="return check()">
		<input type="reset" value="다시작성">
		<input type="button" value="목록보기" onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">		
		</td>
	</tr>
</table>
</form>
<%@include file="../../bottom.jsp" %>