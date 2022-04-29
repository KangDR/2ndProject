<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.Shop.CategoryBean"%>
<%@page import="my.Shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
CategoryDao cdao=CategoryDao.getInstance(); 
ArrayList<CategoryBean> list=cdao.getAllCategory();
%>
<jsp:include page="top.jsp"/>
<td colspan="6" align="center">
	<table border="1">
		<tr>
			<td class="m1">번호</td>
			<td class="m1">카테고리 코드</td>
			<td class="m1">카테고리 이름</td>
			<td class="m1">수정</td>
			<td class="m1">삭제</td>
		</tr>
		<%if(list.size()!=0){ %>
		
			<%for(CategoryBean cb:list){ %>
			<tr>
			<td align="center"><%=cb.getCnum()%></td>
			<td align="center"><%=cb.getCode()%></td>
			<td align="center"><%=cb.getCname()%></td>
			<td align="center" bgcolor="green"><a href="cate_update.jsp?cnum=<%=cb.getCnum()%>&cname=<%=URLEncoder.encode(cb.getCname(), "UTF-8")%>&code=<%=cb.getCode()%>">수정</a></td>
			<td align="center" bgcolor="red"><a href="cate_delete.jsp?cnum=<%=cb.getCnum()%>">삭제</a></td>
		    </tr>
			<%} %>
		<%}
		else{
			%>
			<tr>
				<td colspan="6" align="center">카테고리 없음</td>
			</tr>
			<%
		}
		%>
	</table>
</td>
<jsp:include page="bottom.jsp"/>