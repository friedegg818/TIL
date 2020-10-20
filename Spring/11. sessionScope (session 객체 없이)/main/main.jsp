<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>

<div>
	<h3>메인 화면</h3>
	<div>
		<c:if test="${empty sessionScope.loginMember.userId}">
			<a href="<%=cp%>/login">로그인</a>
		</c:if>
		<c:if test="${not empty sessionScope.loginMember.userId}">
			<a href="<%=cp%>/logout">로그아웃</a>
			| ${sessionScope.loginMember.userName}님
		</c:if>
			| <a href="<%=cp%>/sbbs/list">게시판</a>
	</div>
</div>