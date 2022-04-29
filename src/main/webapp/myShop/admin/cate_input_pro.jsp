<%@page import="my.Shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String code=request.getParameter("code");
String cname=request.getParameter("cname");
CategoryDao cdao=CategoryDao.getInstance();
int cnt=cdao.insertCategory(code,cname);
String msg=null, url=null;
if(cnt>0){
	msg="삽입 성공";
	url=request.getContextPath()+"/myShop/admin/cate_list.jsp";
}
else{
	msg="삽입 실패";
	url=request.getContextPath()+"/myShop/admin/cate_input.jsp";
}
%>
<script type="text/javascript">
alert("<%=msg%>");
location.href="<%=url%>";
</script>