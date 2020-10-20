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

<h3>쇼핑몰</h3>

<table style="width: 300px;">
	<tr align="center">
	    <td width="100">상품명</td>
	    <td width="100">제조사</td>
	    <td width="100">가격</td>
	</tr>
	<tr align="center" onclick="javascript:location.href='1.jsp';" style="cursor: pointer;">
	    <td>냉장고</td>
	    <td>삼싱</td>
	    <td>200</td>
	</tr>
	<tr align="center" onclick="javascript:location.href='2.jsp';" style="cursor: pointer;">
	    <td>핸드폰</td>
	    <td>삼싱</td>
	    <td>190</td>
	</tr>
	<tr align="center" onclick="javascript:location.href='3.jsp';" style="cursor: pointer;">
	    <td>세탁기</td>
	    <td>엘디</td>
	    <td>180</td>
	</tr>
	<tr align="center" onclick="javascript:location.href='4.jsp';" style="cursor: pointer;">
	    <td>건조기</td>
	    <td>엘디</td>
	    <td>210</td>
	</tr>
</table>
<hr>

<h3>오늘본 상품 목록</h3>
<%
	Cookie[] cc = request.getCookies();
	for(Cookie c : cc) {
		String name = c.getName();
		String value = c.getValue();
		
		if(name.startsWith("sname")) {
			value = URLDecoder.decode(value, "UTF-8");
			out.print("<p>"+value+"</p>");
		}
	}
%>


</body>
</html>