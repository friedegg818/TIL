<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	// 세션값 지우기 
	session.removeAttribute("subject");

	session.invalidate();	// 세션의 모든 정보를 삭제하고 세션 객체를 초기화 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> 세션 정보 지우기 </h3>

<p> <a href="ex01.jsp">돌아가기</a> </p>

</body>
</html>