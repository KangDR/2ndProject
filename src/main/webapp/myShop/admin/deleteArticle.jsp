<%@page import="java.io.File"%>
<%@page import="my.wiki.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String title=request.getParameter("title");
String img=request.getParameter("img");
ArticleDao adao=ArticleDao.getInstance();
String deletePath=request.getContextPath()+"/myShop/contents/img";
File deleteFile=new File(deletePath,img);
if(deleteFile.exists()){
	deleteFile.delete();
}
int cnt=-1;
cnt=adao.deleteArticle(title);
if(cnt>0){
	response.sendRedirect("list.jsp");
}
%>