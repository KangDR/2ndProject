<%@page import="my.member.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String id=request.getParameter("id");
MembersDao mdao=MembersDao.getInstance();
boolean flag=false;
flag=mdao.idCheck(id);
if(flag==true){
	out.print("YES");
}
else{
	out.print("NO");
}
%>