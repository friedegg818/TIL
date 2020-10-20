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

<c:forEach var="a" begin="1" end="9">
	5 * ${a} = ${5*a} <br>
</c:forEach>
<hr>

<c:forEach var="a" begin="1" end="9" step="2">
	${a} <br>
</c:forEach>
<hr>

<table border="1" style="border-collapse: collapse;">
	<c:forEach var="a" begin="1" end="9">
		<tr>
			<c:forEach var="b" begin="1" end="9">
				<td width="50">${a * b} </td>		
			</c:forEach>
		</tr>
	</c:forEach>
</table>

</body>
</html>