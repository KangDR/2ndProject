<%@page import="my.member.MemberBean"%>
<%@page import="my.member.MembersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String contextPath=request.getContextPath();
String id=request.getParameter("id");
String pw=request.getParameter("password");
MembersDao mdao=MembersDao.getInstance();
MemberBean mb=mdao.getMemberInfo(id,pw);
String msg, viewPage = null;
	if(mb== null){
		msg ="가입하지 않은 회원입니다.";
		viewPage = contextPath + "/main.jsp" ;// 15_MiniMall/webapp/main.jsp

	}
	else{
		msg = "가입한 회원입니다.";
		String mid = mb.getId();
		int mno=mb.getNo();
		//Httpsession
		session.setAttribute("mid", mid);
		session.setAttribute("mno", mno);
		if(mid.equals("admin")){ // 관리자
			viewPage = contextPath + "/myShop/admin/main.jsp";
		}
		else{ // 일반사용자
			viewPage = contextPath +"/main.jsp";
		}
		
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href  = "<%=viewPage%>";
</script>