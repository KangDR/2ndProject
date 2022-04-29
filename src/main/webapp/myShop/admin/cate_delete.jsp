<%@page import="my.Shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String cnum=request.getParameter("cnum");
CategoryDao cdao=CategoryDao.getInstance();
int cnt=cdao.deleteData(cnum);
String msg=null, url=null;
if(cnt>0){
	msg="삭제 성공";
	url=request.getContextPath()+"/myShop/admin/cate_list.jsp";
}
%>
<script type="text/javascript">
alert("<%=msg%>");
location.href="<%=url%>";
</script>