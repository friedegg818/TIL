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

<p><a href="/study2/bbs/search?subject=자바&page=3">3페이지</a></p>
<p><a href="<c:url value='/bbs/search?subject=자바&page=3'/>">3페이지 : url</a></p>
<hr>

<h3> 한글 인코딩 </h3>
<c:url var="url" value="/bbs/search">
	<c:param name="subject" value="자바"/>
	<c:param name="page" value="3"/>
</c:url>
<p> <a href="${url}">3페이지 : 한글 인코딩</a></p>


</body>
</html>