<%@page import="my.member.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mb" class="my.member.MemberBean"/>
<jsp:setProperty property="*" name="mb"/>
<%
MembersDao mdao=MembersDao.getInstance();
int cnt=0;
String msg=null, url=null;
cnt=mdao.insertMember(mb);
if(cnt>0){
		msg="가입성공";
		url=request.getContextPath()+"/main.jsp";
}
else{
	msg="가입실패";
	url=request.getContextPath()+"/myShop/register.jsp";
}
%>
<script type="text/javascript">
alert("<%=msg%>");
location.href="<%=url%>";
</script>
