<%@page import="my.wiki.ArticleBean"%>
<%@page import="my.wiki.ArticleDao"%>
<%@page import="my.Shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.Shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String title=request.getParameter("title");
ArticleDao adao=ArticleDao.getInstance();
ArrayList<ArticleBean> Alist=adao.searchData(title,"0"); 
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
		if(cb.getCode().equals(Alist.get(0).getCode())){
			Alist.get(0).setCname(cb.getCname());
		}
	}
}
%>
<jsp:include page="../../top.jsp"/>
<form name="myform" method="post" enctype="multipart/form-data" action="updateArticle_proc.jsp">
<div class="container">
<div class="Atitle">제목:<%=Alist.get(0).getTitle()%></div>
<input type="hidden" name="type" value="update">
<input type="hidden" name="title" value='<%=Alist.get(0).getTitle()%>'>
<input type="hidden" name="code" value='<%=Alist.get(0).getCode()%>'>
<input type="hidden" name="oldImg" value='<%=Alist.get(0).getImg()%>'>
<div align="right">
분류(수정불가):<input type="text" name="cname" value="<%=Alist.get(0).getCname()%>" readonly="readonly">
</div>
<div align="right">최종작성자:<input type="text" readonly="readonly" name="prewriter" value="<%=Alist.get(0).getWriter()%>"></div>
<div align="right">현재작성자:<input type="text" readonly="readonly" name="writer" value="<%if(session.getAttribute("mid")==null){%><%=request.getRemoteAddr()%><%}else{%><%=session.getAttribute("mid")%><%}%>"></div>
<div>현재 이미지:
<%if(Alist.get(0).getImg()!=null){ %><img src="<%=request.getContextPath()%>/myShop/contents/img/<%=Alist.get(0).getImg()%>" width='100px' height='100px'><%} else{%>이미지 없음<%} %>
</div>
<div>대표 이미지:<input type="file" name="newImg"></div>
<div class="contents"><textarea name="contents" rows="30" style="width:100%;">
<%=Alist.get(0).getContents()%>
----------------------------------------------
</textarea></div>
<div align="right">
<input type='submit' class="buttons" value='임시저장' onclick='return goTemp(myform);'>
<input type="submit" class="buttons" value="저장하기" onclick="return check()"></div>
</div>
</form>
<jsp:include page="../../bottom.jsp"/>