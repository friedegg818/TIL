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

<p> out : 사이트가 달라도 포함 가능 (include action tag 보다 강력) </p>

<h3>홈페이지 실행 결과</h3>
<c:import url="https://www.google.com" var="google"/>
<c:out value="${google}" escapeXml="false"/>
<hr>

<h3>홈페이지 소스 보기</h3>
<c:import url="https://www.naver.com" var="naver"/>
<c:out value="${naver}" escapeXml="true"/>
<hr>

<h3>홈페이지 소스 보기</h3>
<c:import url="https://www.naver.com"/>
<c:out value="${url}" escapeXml="true"/>
<hr>

</body>
</html>