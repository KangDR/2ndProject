<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="top.jsp" %>
<form name="myform" action="findpwProc.jsp" method="post">
	<table style="margin: auto;margin-top: 100px;">
		<tr>
			<td>
				이름
			</td>
			<td>
				<input type="text" name="name">
			</td>
		</tr>
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
				e-mail
			</td>
			<td>
				<input type="text" name="email">
			</td>
		</tr>
		<tr>
			<td colspan="2" height='48px'>
				<input type="submit" value="찾기" class="buttons">
				<input type="reset" value="초기화" class="buttons">
			</td>
		</tr>
	</table>
</form>
<%@ include file="bottom.jsp" %>