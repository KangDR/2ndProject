<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="top.jsp" %>
<form name="myform" action="loginProc.jsp" method="post">
	<table style="margin: auto;margin-top: 100px;">
		<tr>
			<td>
				ID
			</td>
			<td>
				<input type="text" name="id">
			</td>
		</tr>
		<tr>
			<td>
				PASSWORD
			</td>
			<td>
				<input type="password" name="password">
			</td>
		</tr>
		<tr>
			<td colspan="2" height='48px'>
				<input type="submit" value="로그인" class="buttons">
				<input type="button" value="회원가입" class="buttons" onclick='location.href="myShop/register.jsp"'>
				<input type="button" value="ID찾기" class="buttons" onclick='location.href="findid.jsp"'>
				<input type="button" value="PW찾기" class="buttons" onclick='location.href="findpw.jsp"'>
			</td>
		</tr>
	</table>
</form>
<%@ include file="bottom.jsp" %>