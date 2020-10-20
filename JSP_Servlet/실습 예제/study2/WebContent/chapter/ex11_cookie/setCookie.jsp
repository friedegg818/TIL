<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	Cookie c1 = new Cookie("subject", "jsp");
	c1.setMaxAge(60*60); // 단위 : 초 
	response.addCookie(c1);
	
	// 한글은 반드시 인코딩 
	Cookie c2 = new Cookie("name", URLEncoder.encode("김자바", "UTF-8"));
	// c2.setMaxAge(-1); // 기본. 브라우저가 종료되면 쿠키 제거 
	response.addCookie(c2);
	
	Cookie c3 = new Cookie("city", "seoul");
	c3.setPath("/"); // 모든 경로에서 쿠키 접근 가능. 쿠키는 기본적으로 자신의 경로에서만 접근 가능하다. 
	response.addCookie(c3);
	
	Cookie c4 = new Cookie("age", "20");
	c4.setMaxAge(0); // 생성과 동시에 제거 
	response.addCookie(c4);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> 쿠키 설정 </h3>

<p> <a href="ex01.jsp"> 돌아가기 </a> </p>


</body>
</html>