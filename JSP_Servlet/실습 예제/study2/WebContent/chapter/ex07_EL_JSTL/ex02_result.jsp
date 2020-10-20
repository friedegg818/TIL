<%@page import="com.user.UserVO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> EL을 이용한 출력 </h3>
EL을 이용하면 getAttibute()를 사용하지 않고도 간단하게 내용을 가져 올 수 있다. 
단, 필드에 있는 값을 가져 올 때에는 반드시 getter/setter 가 필요하며 대소문자도 명확히 구분해야 함.

<p> ${param.name} </p>
<p> ${vo.name} </p>
<p> ${vo.age} </p>
<p> ${result} </p>
 
</body>
</html>