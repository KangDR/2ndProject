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
<%
request.setCharacterEncoding("UTF-8");
String cnum=request.getParameter("cnum");
String cname=request.getParameter("cname");
String code=request.getParameter("code");
%>
<%@ include file="top.jsp"%>
<td colspan="6" align="center">
		<b>카테고리 수정(이름만 수정가능)</b>
		<form name="myform" action="cate_update_pro.jsp" method="post">
		<input type="hidden" value="<%=cnum%>" name="cnum">
		<table border="1">
			<tr>
				<th class="m1">
				카테고리 코드
				</th>
				<td>
				<input type="text" name="code" value="<%=code%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th class="m1">
				카테고리 이름
				</th>
				<td>
				<input type="text" name="cname" value="<%=cname%>">
				</td>
			</tr>
			<tr>
			<td colspan="2" align="center" class="m1">
				<input type="submit" value="수정" onclick="return check()">
				<input type="reset" value="초기화">
			</td>
			</tr>
		</table>
		</form>
	</td>
<%@ include file="bottom.jsp"%>