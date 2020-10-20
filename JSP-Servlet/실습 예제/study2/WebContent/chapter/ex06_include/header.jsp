<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");

	// jsp:param 액션 태그는 request.getParameter()로 넘겨 받는다. 
	String menuItem = request.getParameter("menuItem");
	if(menuItem==null) menuItem="";
%>

<ul>
	<li><a href="main.jsp" class="menuItem">홈</a></li>
<% if(menuItem.equals("guest")) { %>
	<li style="font-weight: 700; color:gold;">방명록</li>
<% } else { %>
	<li><a href="guest.jsp" class="menuItem">방명록</a></li>
<% } %>
	<li><a href="bbs.jsp" class="menuItem">게시판</a></li>
	<li><a href="#.jsp" class="menuItem">일정관리</a></li>
	<li><a href="#.jsp" class="menuItem">공지사항</a></li>
</ul>
