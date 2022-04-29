<%@page import="my.Board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
int pageNum=Integer.parseInt(request.getParameter("pageNum"));
%>
<jsp:useBean id="bb" class="my.Board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>
<%
bb.setNum(Integer.parseInt(request.getParameter("num")));
BoardDao bdao=BoardDao.getInstance();
int cnt=bdao.updateArticle(bb);

if(cnt>0){
	response.sendRedirect("list.jsp?pageNum="+pageNum);
}
else{%>
<script type="text/javascript">
	alert('비밀번호');
	history.go(-1);
</script>
<%	
//response.sendRedirect("updateForm.jsp?num="+bb.getNum());
}
%>