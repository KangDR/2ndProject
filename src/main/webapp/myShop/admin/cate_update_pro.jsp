<%@page import="my.Shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="cb" class="my.Shop.CategoryBean"/>
<jsp:setProperty property="*" name="cb"/>
<%
CategoryDao cdao=CategoryDao.getInstance();
int cnt=cdao.updateData(cb);
String msg=null, url=null;
if(cnt>0){
	msg="수정 성공";
	url=request.getContextPath()+"/myShop/admin/cate_list.jsp";
}
else{
	msg="수정 실패";
	url=request.getContextPath()+"/myShop/admin/cate_input.jsp";
}
%>
<script type="text/javascript">
alert("<%=msg%>");
location.href="<%=url%>";
</script>