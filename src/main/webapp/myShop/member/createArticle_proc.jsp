<%@page import="my.wiki.ArticleBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.wiki.ArticleDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="temp" class="my.wiki.TempBean" scope="session"/>
<%
ArrayList<ArticleBean> list=temp.getAllTemp();
String saveFolder="img";
int maxSize=1024*1024*5;
String encType="UTF-8";
String configFolder=config.getServletContext().getRealPath("/myShop/contents/img");
MultipartRequest mr=new MultipartRequest(request,configFolder,maxSize,encType,new DefaultFileRenamePolicy());
String img=mr.getFilesystemName("img");
String oimg=mr.getParameter("oimg");
if(oimg!=null&&img==null){
	img=oimg;
}
%>
<img src="<%=configFolder+"/"+img%>">
<jsp:setProperty property="*" name="mr"/>
<%
System.out.print(img);
ArticleDao adao=ArticleDao.getInstance();
int cnt=adao.insertData(mr,img);
if(cnt>0){
	response.sendRedirect(request.getContextPath()+"/main.jsp");
	for(int i=0;i<list.size();i++){
		if(list.get(i).getTitle().equals(mr.getParameter("title"))){
			list.remove(i);
		}
	}
}
else{
%>
<script type="text/javascript">
alert("삽입 실패(이름 중복등)");
history.back();
</script>
<%}%>