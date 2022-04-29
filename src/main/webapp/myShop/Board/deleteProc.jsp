<%@page import="my.Board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
deleteProc.jsp<br>
<%
request.setCharacterEncoding("UTF-8");
int num=Integer.parseInt(request.getParameter("num"));
String num2=request.getParameter("pageNum");
System.out.println(request.getParameter("pageNum"));
int pageNum=Integer.parseInt(num2);
String passwd=request.getParameter("passwd");
BoardDao bdao=BoardDao.getInstance();
int pageSize=5;
int count=bdao.getArticleCount();
int pageCount=count/pageSize+(count%pageSize==0?0:1);
int cnt=bdao.deleteArticle(num, passwd);
if(cnt>0){
	if(pageNum>pageCount){
		response.sendRedirect("list.jsp?pageNum="+(pageNum-1));}
		else{
			response.sendRedirect("list.jsp?pageNum="+(pageNum));
		}
}
else{%>
<script type="text/javascript">
	alert('비밀번호를 확인하세요');
	history.go(-1);
</script>
<%	
//response.sendRedirect("updateForm.jsp?num="+bb.getNum());
}
%>