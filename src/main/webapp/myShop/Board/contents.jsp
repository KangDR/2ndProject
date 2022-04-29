<%@page import="java.text.SimpleDateFormat"%>
<%@page import="my.Board.BoardBean"%>
<%@page import="my.Board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String number=request.getParameter("num");
String pageNum=request.getParameter("pageNum");
int num=Integer.parseInt(number);
BoardDao bdao=BoardDao.getInstance();
BoardBean bb=bdao.getArticle(num);
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%@include file="../../top.jsp" %>
<div style="text-align: center;"><b>글내용보기</b></div>
<form>
	<table border="1" width="600" style="margin: auto;">
		<tr>
			<td bgcolor="#09AD35">글번호</td>
			<td bgcolor="#BFBFBF"><%=bb.getNum() %></td>
			<td bgcolor="#09AD35">조회수</td>
			<td bgcolor="#BFBFBF"><%=bb.getReadcount() %></td>
		</tr>
		<tr>
			<td bgcolor="#09AD35">작성자</td>
			<td bgcolor="#BFBFBF"><%=bb.getWriter() %></td>
			<td bgcolor="#09AD35">작성일</td>
			<td bgcolor="#BFBFBF"><%=sdf.format(bb.getReg_date())%></td>
		</tr>
		<tr>
			<td bgcolor="#09AD35">글제목</td>
			<td bgcolor="#BFBFBF" colspan="3"><%=bb.getSubject() %></td>
		</tr>
		<tr height="400">
			<td bgcolor="#09AD35">글내용</td>
			<td bgcolor="#BFBFBF" colspan="3"><%=bb.getContent() %></td>
		</tr>
		<tr>
			<td colspan="4" align="right" bgcolor="black">
				<input type="button" value="글수정" onclick="location.href='updateForm.jsp?num=<%=bb.getNum() %>&pageNum=<%=pageNum%>'">
				<input type="button" value="글삭제" onclick="location.href='deleteForm.jsp?num=<%=bb.getNum() %>&pageNum=<%=pageNum%>'">
				<input type="button" value="답글쓰기" onclick="location.href='replyForm.jsp?num=<%=bb.getNum() %>&ref=<%=bb.getRef()%>&re_step=<%=bb.getRe_step()%>&re_level=<%=bb.getRe_level()%>&pageNum=<%=pageNum%>'">
				<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">
			</td>
		</tr>		
	</table>
</form>
<%@include file="../../bottom.jsp" %>