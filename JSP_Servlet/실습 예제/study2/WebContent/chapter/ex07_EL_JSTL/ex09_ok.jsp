<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> EL 및 JSTL Map 접근 </h3>

${map.name} | ${map.city} | ${map['tel']} <br>
<hr>

<c:forEach var="m" items="${map}">
	${m.key} | ${m.value} <br>
</c:forEach>
<hr>

<c:forEach var="m" items="${list}">
	${m.name} | ${m.subject} <br>
</c:forEach>

</body>
</html>