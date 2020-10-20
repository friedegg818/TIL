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

<h3>${dto.title}</h3>

<div>
	<p> ${dto.userName}님의 블로그 입니다. </p>
	<p> 블로그 주제 : ${dto.blogGroup} </p>
	<p> <a href="<%=cp%>/blog">돌아가기</a> </p>	
</div>

</body>
</html>