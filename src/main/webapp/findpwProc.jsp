<%@page import="my.member.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String id=request.getParameter("id");
String name=request.getParameter("name");
String email=request.getParameter("email");
MembersDao mdao=MembersDao.getInstance();
String pw=mdao.findPw(id,name,email);
String msg=null, url=null;
if(pw==null){
	msg="입력하신 정보가 없습니다.";
	url="findpw.jsp";
}
else{
	msg="비밀번호는"+pw+"입니다.";
	url="login.jsp";
}
%>
<script type="text/javascript">
alert("<%=msg%>");
location.href="<%=url%>";
</script>