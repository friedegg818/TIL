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

<form method="post">
	<input type="text" name="num1" value="${param.num1}">
	<select name="oper">
		<option value="+" ${param.oper=="+" ? "selected='selected'" : ""}>더하기</option>
		<option value="-" ${param.oper=="-" ? "selected='selected'" : ""}>빼기</option>
		<option value="*" ${param.oper=="*" ? "selected='selected'" : ""}>곱하기</option>
		<option value="/" ${param.oper=="/" ? "selected='selected'" : ""}>나누기</option>	
	</select>
	<input type="text" name="num2" value="${param.num2}">
	<button type="submit">결과</button>
</form>

<c:if test="${not empty param.num1 and not empty param.num2}">
	<c:if test="${param.oper=='+'}">${param.num1 + param.num2}</c:if>
	<c:if test="${param.oper=='-'}">${param.num1 - param.num2}</c:if>
	<c:if test="${param.oper=='*'}">${param.num1 * param.num2}</c:if>
	<c:if test="${param.oper=='/'}">${param.num1 / param.num2}</c:if>
</c:if>

</body>
</html>