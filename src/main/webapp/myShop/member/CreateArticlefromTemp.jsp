<%@page import="my.wiki.ArticleBean"%>
<%@page import="my.Shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.Shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
use="impossible";
isCheck=false;
function titleCheck(){
	$("input[name='title']").keydown(function(){
		$('#titleCheck').css("display","none");
		use="";
		isCheck=false;
	})
	$.ajax({
		url:"titleCheck.jsp",
		data:({
			title:$("input[name='title']").val()
		}),
		success:function(data){
			if($("input[name='title']").val().length==0){
				$('#titleCheck').html("<font color=red>입력 누락.");
				$('#titleCheck').show();
			}
			else if($.trim(data)=="NO"){
				$('#titleCheck').html("<font color=green>사용 가능합니다.");
				use="possible";
				isCheck=true;
				$('#titleCheck').show();
			}
			else if($.trim(data)=="YES"){
				$('#titleCheck').html("<font color=red>사용 불가능합니다.");
				use="impossible";
				isCheck=true;
				$('#titleCheck').show();
			}
		}
	})
}
function check(){
	if(document.myform.title.value==""){
		alert("제목이 누락되었습니다.");
		return false;
	}
	if(document.myform.contents.value==""){
		alert("내용이 누락되었습니다.");
		return false;
	}
	if(isCheck==false){
		alert("중복체크하세요");
		return false;
	}
	if(use=="impossible"){
		alert("제목이 중복됩니다.")
		return false;
	}
}
function goTemp(frm) { 
    frm.action='./../member/createTemp.jsp'; 
    frm.submit(); 
    return true; 
  } 
</script>
<jsp:useBean id="temp" class="my.wiki.TempBean" scope="session"/>
<%
String title=request.getParameter("title");
String code="",writer="", img="",contents="";
CategoryDao cdao=CategoryDao.getInstance();
ArrayList<CategoryBean> list=cdao.getAllCategory();
ArrayList<ArticleBean> tlist=temp.getAllTemp();
for(ArticleBean ab:tlist){
	if(ab.getTitle().equals(title)){
		code=ab.getCode();
		writer=ab.getWriter();
		img=ab.getImg();
		contents=ab.getContents();
	}
}
%>
<jsp:include page="../../top.jsp"/>
<form name="myform" method="post" enctype="multipart/form-data" action="createArticle_proc.jsp">
<div class="container">
<div class="Atitle">제목:<input style="height: 32px" type="text" name="title" height="32px" value="<%=title%>"><input type="button" value="제목확인" onclick="titleCheck()">
<br>
<span id="titleCheck"></span>
<br>
[새 문서 생성하기]</div>
<div align="right">
분야 선택:
<select name="code">
	<%for(CategoryBean cb:list){ %><option value="<%=cb.getCode()%>" <%if(cb.getCode().equals(code)){%>selected<%} %>><%=cb.getCname()%></option><%} %>
</select>
</div>
<div align="right">작성자:<input type="text" readonly="readonly" name="writer" value="<%if(session.getAttribute("mid")==null){%><%=request.getRemoteAddr()%><%}else{%><%=session.getAttribute("mid")%><%}%>"></div>
<div>
<%if(img!=null){%><img src='<%=request.getContextPath()+"/myShop/contents/img/"+img%>' width='100px' height='100px'><input type="hidden" name="oimg" value="<%=img%>"><%}%>
대표 이미지:<input type="file" name="img">
</div>
<div class="contents"><textarea name="contents" rows="30" style="width:100%;"><%=contents %></textarea></div>
<br>
<div align="right">
<input type='submit' class="buttons" value='임시저장' onclick='return goTemp(myform);'> 
<input type="submit" class="buttons" value="입력하기" onclick="return check()"></div>
</div>
</form>
<jsp:include page="../../bottom.jsp"/>