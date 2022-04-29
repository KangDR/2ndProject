<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="my.Shop.CategoryBean"%>
<%@page import="my.Shop.CategoryDao"%>
<%@page import="my.wiki.ArticleBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.wiki.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd.HH:mm:ss");
String saveFolder="img";
int maxSize=1024*1024*5;
String encType="UTF-8";
String configFolder=config.getServletContext().getRealPath("/myShop/contents/img");
String timeStamp = date.format(new Date());
MultipartRequest mr=new MultipartRequest(request,configFolder,maxSize,encType,new DefaultFileRenamePolicy());
String title=mr.getParameter("title");
String code=mr.getParameter("code");
String writer=mr.getParameter("writer");
String img=mr.getFilesystemName("newImg");
String oimg=mr.getParameter("oldImg");
if(oimg.equals("null")){
	oimg=null;
}
String type="update";
if(img==null&&oimg!=null){
	img=oimg;
}
String uploadDir=config.getServletContext().getRealPath("myShop/contents/img");
String contents=mr.getParameter("contents");
%>
<jsp:useBean id="temp" class="my.wiki.TempBean" scope="session"/>
<%temp.addTemp(title, code, writer, contents, timeStamp,img,type); %>
<script type="text/javascript">
location.href="tempList.jsp";
</script>