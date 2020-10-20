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
	<p> ${param.num} : ${ param.num % 2 == 0 ? "짝수":"홀수"} </p>
</c:if>

<form method="post">
<p>
	<input type="text" name="num">
	<button type="submit">확인</button>
</p>
</form>

</body>
</html>