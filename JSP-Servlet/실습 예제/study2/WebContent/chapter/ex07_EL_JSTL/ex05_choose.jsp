<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<c:if test="${not empty param.num }">
	<p> 
		<c:choose>
			<c:when test="${param.num % 12 == 0}">
				${param.num} : 3과 4의 배수 			
			</c:when>
			<c:when test="${param.num % 3 == 0}">
				${param.num} : 3의 배수 			
			</c:when>
			<c:when test="${param.num % 4 == 0}">
				${param.num} : 4의 배수 			
			</c:when>
			<c:otherwise>
				${param.num} : 3 또는 4의 배수가 아니다.
			</c:otherwise>
		</c:choose>
	</p>
</c:if>

<form method="post">
<p>
	<input type="text" name="num">
	<button type="submit">확인</button>
</p>
</form>

</body>
</html>