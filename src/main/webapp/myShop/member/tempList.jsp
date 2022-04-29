<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="my.wiki.ArticleBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="temp" class="my.wiki.TempBean" scope="session"/>
<%
ArrayList<ArticleBean> list=temp.getAllTemp();
String uploadDir=config.getServletContext().getRealPath("myShop/contents/img");

%>
<%@include file="../../top.jsp"%>
<style type="text/css">
th{
	background-color: #519d9e;
}
</style>
<div class="container">
<table style="margin-left: auto; margin-right: auto; padding-top: 20px; padding-bottom: 20px" width="600px">
	<tr>
		<th>분류</th>
		<th>제목</th>
		<th>작성자</th>
		<th>이미지</th>
		<th>저장시간</th>
		<th>삭제</th>
	</tr>
	<%
	if(list.size()==0){%>
	<tr><td colspan="6" style="text-align: center;">내역이 없습니다.</tr>
	<%
	}
	for(int i=0;i<list.size();i++){%>
	<tr>
		<td><%=list.get(i).getCode() %></td>
		<td><%if(list.get(i).getType().equals("create")){ %><a href="CreateArticlefromTemp.jsp?title=<%=URLEncoder.encode(list.get(i).getTitle(),"UTF-8")%>">
		<%}else{%>
		<a href="UpdateArticlefromTemp.jsp?title=<%=URLEncoder.encode(list.get(i).getTitle(),"UTF-8")%><%if(list.get(i).getImg()!=null){ %>&img=<%=URLEncoder.encode(list.get(i).getImg(),"UTF-8")%><%}%>">
		<%} %>
		<%=list.get(i).getTitle() %></a></td>
		<td><%=list.get(i).getWriter() %></td>
		<td>
		<%if(list.get(i).getImg()!=null){
			File dir=new File(uploadDir,list.get(i).getImg());
			if(dir.exists()){
		%>
		<img src='<%=request.getContextPath()+"/myShop/contents/img/"+list.get(i).getImg()%>' width='100px' height='100px'>
		<%}
			else{
				%><img src='<%=request.getContextPath()+"/myShop/contents/img/"+list.get(i).getImg()%>' width='100px' height='100px'>
				<%
			}
			}
		else{
		%>
		이미지 없음
		<%} %>
		</td>
		<td><%=list.get(i).getReg_date() %></td>
		<td><a href='deleteTemp.jsp?title=<%=URLEncoder.encode(list.get(i).getTitle(),"UTF-8")%>'>삭제</a></td>
	</tr>
	<%}%>
</table>
<div align="right"><input type="button" value="전부 제거" onclick="location.href='deleteTemp.jsp'"></div>
</div>
<%@include file="../../bottom.jsp"%>