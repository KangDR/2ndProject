<%@page import="java.io.File"%>
<%@page import="my.Shop.CategoryBean"%>
<%@page import="my.Shop.CategoryDao"%>
<%@page import="my.wiki.ArticleBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.wiki.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="temp" class="my.wiki.TempBean" scope="session"/>
<%
String title=request.getParameter("title");
String uoldImg=request.getParameter("img");
ArticleDao adao=ArticleDao.getInstance();
ArrayList<ArticleBean> Alist=temp.getAllTemp();
String utitle="",ucode="",ucontents="",ucname="";
for(ArticleBean ab:Alist){
	if(ab.getTitle().equals(title)){
		utitle=ab.getTitle();
		ucode=ab.getCode();
		ucontents=ab.getContents();
	}
}
String uploadDir=config.getServletContext().getRealPath("myShop/contents/img");

%>
<script type="text/javascript">
function check(){
	if(document.myform.contents.value==""){
		alert("내용이 누락되었습니다.");
		return false;
	}
}
function goTemp(frm) { 
    frm.action='./../member/updateTemp.jsp'; 
    frm.submit(); 
    return true; 
  } 
</script>
<%
CategoryDao cdao=CategoryDao.getInstance();
ArrayList<CategoryBean> list=cdao.getAllCategory();
if(Alist!=null&&list!=null){
	for(CategoryBean cb:list){
		if(cb.getCode().equals(ucode)){
			ucname=cb.getCname();
		}
	}
}
%>
<jsp:include page="../../top.jsp"/>
<form name="myform" method="post" enctype="multipart/form-data" action="updateArticle_proc.jsp">
<div class="container">
<div class="Atitle">제목:<%=utitle%></div>
<input type="hidden" name="type" value="update">
<input type="hidden" name="title" value='<%=utitle%>'>
<input type="hidden" name="code" value='<%=ucode%>'>
<input type="hidden" name="oldImg" value='<%=uoldImg%>'>
<div align="right">
분류(수정불가):<input type="text" name="cname" value="<%=ucname%>" readonly="readonly">
</div>
<div align="right">작성자:<input type="text" readonly="readonly" name="writer" value="<%if(session.getAttribute("mid")==null){%><%=request.getRemoteAddr()%><%}else{%><%=session.getAttribute("mid")%><%}%>"></div>
<div>현재 이미지:
<%if(uoldImg!=null){ 
%>
<img src="<%=request.getContextPath()%>/myShop/contents/img/<%=uoldImg%>" width='100px' height='100px'>
<%
} 
else{%>이미지 없음<%} %>
</div>
<div>대표 이미지:<input type="file" name="newImg"></div>
<div class="contents"><textarea name="contents" rows="30" style="width:100%;">
<%=ucontents%>
----------------------------------------------
</textarea></div>
<div align="right">
<input type='submit' class="buttons" value='임시저장' onclick='return goTemp(myform);'>
<input type="submit" class="buttons" value="저장하기" onclick="return check()"></div>
</div>
</form>
<jsp:include page="../../bottom.jsp"/>