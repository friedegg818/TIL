<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> 쿠키 확인 </h3>

<%
	Cookie[] cc = request.getCookies();
	for(Cookie c : cc) {
		String name = c.getName();
		String value = c.getValue();
		
		if(name.equals("name")) {
			value = URLDecoder.decode(value,"UTF-8");
		}
		
		out.print("<p>"+name+":"+value+"</p>");
	}
%>

<p> <a href="ex01.jsp"> 돌아가기 </a> </p>

</body>
</html>