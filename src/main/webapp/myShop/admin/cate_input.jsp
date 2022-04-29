<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
function check(){
	if(document.myform.code.value==""){
	alert("카테고리 코드를 입력하세요");
	return false;
	}
	if(document.myform.cname.value==""){
	alert("카테고리 이름을 입력하세요");
	return false;
	}
}
</script>
<%@ include file="top.jsp"%>
<td colspan="6" align="center">
		<b>카테고리 등록</b>
		<form name="myform" action="cate_input_pro.jsp" method="post">
		<table border="1">
			<tr>
				<th class="m1">
				카테고리 코드
				</th>
				<td>
				<input type="text" name="code">
				</td>
			</tr>
			<tr>
				<th class="m1">
				카테고리 이름
				</th>
				<td>
				<input type="text" name="cname">
				</td>
			</tr>
			<tr>
			<td colspan="2" align="center" class="m1">
				<input type="submit" value="등록" onclick="return check()">
				<input type="reset" value="취소">
			</td>
			</tr>
		</table>
		</form>
	</td>
<%@ include file="bottom.jsp"%>