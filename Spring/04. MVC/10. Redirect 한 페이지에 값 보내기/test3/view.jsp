<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h3> 리다이렉트 된 페이지 > </h3>

<p> 이름  : ${dto.name} </p>
<p> 전화 : ${dto.tel} </p>
<p> 나이 : ${dto.age} </p>
<p> 메세지 : ${msg} </p>

</body>
</html>