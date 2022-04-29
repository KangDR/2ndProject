<%@page import="my.member.MemberBean"%>
<%@page import="my.member.MembersDao"%>
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
<link rel="stylesheet" href="style.css">
<%
String ref=request.getParameter("ref"); 
String re_step=request.getParameter("re_step"); 
String re_level=request.getParameter("re_level");
String pageNum=request.getParameter("pageNum");
MembersDao mdao=MembersDao.getInstance();
MemberBean mb=mdao.searchId((String)session.getAttribute("mid"));
%>
<%@include file="../../top.jsp" %>
<div style="text-align: center;">
<b>답글쓰기</b>
<form method="post" action="replyProc.jsp">
<input type="hidden" name="ref" value=<%=ref %>>
<input type="hidden" name="re_step" value=<%=re_step %>>
<input type="hidden" name="re_level" value=<%=re_level %>>
<table border="1" style="margin: auto;">
	<tr>
		<td bgcolor="black" colspan="2" align="right"><a href="list.jsp">글목록</a></td>
	</tr>
	<tr>
		<td bgcolor="#09AD35" align="center">작성자</td>
		<td bgcolor="#BFBFBF"><input type="text" name="writer" value="<%if(session.getAttribute("mid")!=null){%><%=session.getAttribute("mid")%><%}else{%><%=request.getRemoteAddr()%> <%}%>"></td>
	</tr>
	<tr>
		<td bgcolor="#09AD35" align="center">제목</td>
		<td bgcolor="#BFBFBF"><input type="text" name="subject" value="[답글]"></td>
	</tr>
	<tr>
		<td bgcolor="#09AD35" align="center">Email</td>
		<td bgcolor="#BFBFBF"><input type="text" name="email" value="<%if(session.getAttribute("mid")!=null){%><%=mb.getEmail()%><%}else{%>abc@mail.com<%}%>"></td>
	</tr>
	<tr>
		<td bgcolor="#09AD35" align="center">내용</td>
		<td bgcolor="#BFBFBF"><textarea cols="50" rows="20" name="content">내용 입력</textarea></td>
	</tr>
	<tr>
		<td bgcolor="#09AD35" align="center">비밀번호(기본:1234)</td>
		<td bgcolor="#BFBFBF"><input type="password" name="passwd" value="1234"></td>
	</tr>
	<tr>
		<td bgcolor="black" colspan="2" align="center">
		<input type="submit" value="글쓰기" onclick="return check()">
		<input type="reset" value="다시작성">
		<input type="button" value="목록보기" onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">		
		</td>
	</tr>
</table>
</form>
</div>
<%@include file="../../bottom.jsp" %>