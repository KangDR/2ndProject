<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String conPath=request.getContextPath(); %>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('input[name="search"]').keyup(function(){
		$.ajax({
			url:"topajax.jsp",
			data:({
				search:$("input[name='search']").val()
			}),
			success:function(data){
			array1=data.replace("[","");
			array2=array1.replace("]","");
			array=array2.split(",");
			str="";
			str+="<datalist id='listid'>";
			for(var i in array){
				str+="<option label='"+$.trim(array[i])+"' value='"+$.trim(array[i])+"'>";
				}
			str+="</datalist>";
			if($("input[name='search']").val()!=""){
				$("input[name='search']").html(str);
			}
			}
		})
	})
})
</script>
<link href="<%=conPath%>/style.css" rel="stylesheet">
<div style="text-align: center;" class="firstline"><span><strong><a href="<%=conPath%>/main.jsp">중앙위키</a></strong></span></div><div class="firstline" style="text-align: center;"><span>
<%if(session.getAttribute("mid")==null){ %><a href="<%=conPath%>/login.jsp">로그인</a> | <a href="<%=conPath %>/myShop/register.jsp">회원가입</a><%}
else{
%>
<%=session.getAttribute("mid")%>님 환영합니다. |<%if(session.getAttribute("mid").equals("admin")){%><a href="<%=conPath%>/main.jsp">사용자홈</a><%} %>| <a href="<%=conPath%>/logout.jsp">로그아웃</a>
<%
}
%>
 | <a href="<%=conPath%>/myShop/contents/recentChanged.jsp">최근 변경</a> | <a href="<%=conPath%>/myShop/contents/CreateArticle.jsp">새글 쓰기</a> | <a href="<%=conPath%>/myShop/member/myContribute.jsp?writer=<%if(session.getAttribute("mid")!=null){%><%=session.getAttribute("mid")%><%}%><%else{%><%=request.getRemoteAddr()%><%}%>">내 기여목록</a> | <a href="<%=conPath%>/myShop/member/tempList.jsp">임시저장 목록</a> | <a href="<%=conPath%>/myShop/Board/list.jsp">게시판</a></span></div>
<div class="secondline">
<a href="<%=conPath%>/myShop/contents/randomContents.jsp"><img src="<%=conPath%>/images/random.png" height="32px" width="32px"></a>
<form action="<%=conPath%>/myShop/contents/contents.jsp">
<input type="text" name="search" placeholder="검색어" style="width:200px;box-sizing: border-box;" list="listid">
<input type="submit" value="검색">
</form>
</div>
<table border="0" width="800" height="400" style="margin-left: auto; margin-right: auto; padding-top: 20px; padding-bottom: 20px">
	<tr>
		<th align="center" class="m1">
			<a href="<%=request.getContextPath()%>/myShop/admin/cate_input.jsp">카테고리 등록</a>
		</th>
		<th align="center" class="m1">
			<a href="<%=request.getContextPath()%>/myShop/admin/cate_list.jsp">카테고리 목록</a>
		</th>
		<th align="center" class="m1">
			<a href="<%=request.getContextPath()%>/myShop/admin/list.jsp">위키 목록</a>
		</th>
		<th align="center" class="m1">
			<a href="<%=request.getContextPath()%>/myShop/admin/wikilist_member.jsp">사용자별 수정 내역</a>
		</th>
	</tr>
	<tr height="320">