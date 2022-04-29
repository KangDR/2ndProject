<%@page import="my.wiki.ArticleBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="my.wiki.ArticleDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="temp" class="my.wiki.TempBean" scope="session"/>
<%
ArrayList<ArticleBean> list=temp.getAllTemp();
ArticleDao adao=ArticleDao.getInstance();
int maxSize=1024*1024*5;
String encType="UTF-8";
String uploadDir=config.getServletContext().getRealPath("myShop/contents/img");
MultipartRequest mr=new MultipartRequest(request,uploadDir,maxSize,"UTF-8",new DefaultFileRenamePolicy());
String title=mr.getParameter("title");
String code=mr.getParameter("code");
String writer=mr.getParameter("writer");
String contents=mr.getParameter("contents");
String newImg = mr.getFilesystemName("newImg");
String oldImg =mr.getParameter("oldImg");
int cnt=adao.updateData(mr,oldImg);
if(cnt>0){
	for(int i=0;i<list.size();i++){
		if(list.get(i).getTitle().equals(mr.getParameter("title"))){
			list.remove(i);
		}
	}
	response.sendRedirect("tempList.jsp");
}
else{
%>
<script type="text/javascript">
alert("수정실패");
</script>
<%
	response.sendRedirect("contents.jsp?search="+title);
}
%>