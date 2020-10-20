<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> 지금은 <tf:now/> 입니다. </p>

<tf:header title="2020년 5월 20일"/>
<tf:header title="수요일" level="3"/>

<tf:header2>
	<jsp:attribute name="title">예제...</jsp:attribute>
</tf:header2>

<tf:grade subject="자바" score="92"/><br>
<tf:grade subject="JSP" score="74"/>

<p>
	<tf:select name="city" seoul="서울" busan="부산" incheon="인천"/>
</p>

</body>
</html>