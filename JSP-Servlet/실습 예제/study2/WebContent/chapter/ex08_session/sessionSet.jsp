<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	// session : 세션을 나타내는 JSP 내장 객체 
	// 서블릿 : HttpSession session = request.getSession();

	session.setMaxInactiveInterval(60*20); // 세션 유지시간. 단위:초, 기본 30분 
	// 세션에 값 저장
	session.setAttribute("subject", "java");
	session.setAttribute("score", 80);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>세션 설정</h3>

<p><a href="ex01.jsp">돌아가기</a></p>

</body>
</html>