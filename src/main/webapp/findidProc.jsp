<%@page import="my.member.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String name=request.getParameter("name");
String email=request.getParameter("email");
MembersDao mdao=MembersDao.getInstance();
String id=mdao.findId(name,email);
String msg=null, url=null;
if(id==null){
	msg="입력하신 정보가 없습니다.";
	url="findid.jsp";
}
else{
	msg="ID는"+id+"입니다.";
	url="login.jsp";
}
%>
<script type="text/javascript">
alert("<%=msg%>");
location.href="<%=url%>";
</script>