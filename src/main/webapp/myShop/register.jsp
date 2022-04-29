<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<script type="text/javascript" src="<%=conPath%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=conPath%>/script.js"></script>
<script type="text/javascript">
isCheck=false;
</script>
<style type="text/css">
td:first-child{
	text-align: center;
	background-color: #77af9c;
}
</style>
<div class="contents">
<form action="registerPro.jsp" method="post" onsubmit="return writeSave()">
	<table border="1" style="margin: auto;margin-top: 100px;">
		<tr>
			<td colspan="2">기본 정보(*표시는 필수입력사항입니다.)</td>
		</tr>
		<tr>
			<td>*회원 아이디</td>
			<td><input type="text" name="id">
			<input type="button" name="idcheck" value ="중복 체크" onclick="duplicate()"> 
			<span id="idcheck"></span></td>
		</tr>
		<tr>
			<td>*비밀 번호</td>
			<td><input type="password" name="password" onblur="return pwcheck()"> 영문 소문자/숫자 조합 3~8자</td>
		</tr>
		<tr>
			<td>*비밀 번호 확인</td>
			<td>
			<input type="password" name="password2" onkeyup="repwcheck()">
			<span id="pwmessage"></span>
			</td>
		</tr>
		<tr>
			<td>*이름</td>
			<td><input type="text" name="name"> 성과 이름을 붙여 주세요 (예)홍길동</td>
		</tr>
		<tr>
			<td>*E-Mail</td>
			<td><input type="text" name="email"></td>
		</tr>
		<tr>
			<td>휴대전화번호</td>
			<td>
			<select name="phone1">
				<option>010</option>
				<option>011</option>
				<option>017</option>
				<option>019</option>
			</select>
			-<input type="text" name="phone2" maxlength="4" size="4">-<input type="text" name="phone3" maxlength="4" size="4"></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="가입하기">
				<input type="reset" value="취소">
			</td>
		</tr>
	</table>
</form>
</div>
<%@ include file="../bottom.jsp"%>