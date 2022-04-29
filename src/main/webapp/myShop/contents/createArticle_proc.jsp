<%@page import="my.wiki.ArticleDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String saveFolder="img";
int maxSize=1024*1024*5;
String encType="UTF-8";
String configFolder=config.getServletContext().getRealPath("/myShop/contents/img");
MultipartRequest mr=new MultipartRequest(request,configFolder,maxSize,encType,new DefaultFileRenamePolicy());
String img=mr.getFilesystemName("img");
%>
<img src="<%=configFolder+"/"+img%>">
<jsp:setProperty property="*" name="mr"/>
<%
ArticleDao adao=ArticleDao.getInstance();
int cnt=adao.insertData(mr,img);
if(cnt>0){
	response.sendRedirect(request.getContextPath()+"/main.jsp");
}
else{
%>
<script type="text/javascript">
alert("삽입 실패(이름 중복등)");
history.back();
</script>
<%}%>