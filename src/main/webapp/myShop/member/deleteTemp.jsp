<%@page import="my.wiki.ArticleBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="temp" class="my.wiki.TempBean" scope="session"/>
<%
String title=request.getParameter("title");
String uploadDir=config.getServletContext().getRealPath("myShop/contents/img");
ArrayList<ArticleBean> list=temp.getAllTemp();
if(title==null){
for(int i=0;i<list.size();i++){
	if(list.get(i).getImg()!=null){
		File dir=new File(uploadDir,list.get(i).getImg());
		if(dir.exists()){
		dir.delete();}
	}
}
temp.removeAllproduct();
response.sendRedirect("tempList.jsp");
}
else{
	for(int i=0;i<list.size();i++){
		if(list.get(i).getTitle().equals(title)){
			list.remove(i);
		}
	}
	response.sendRedirect("tempList.jsp");
}
%>
