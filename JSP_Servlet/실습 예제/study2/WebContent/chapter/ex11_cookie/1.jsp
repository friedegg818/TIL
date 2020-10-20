<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	Cookie c = new Cookie("sname1", URLEncoder.encode("냉장고","UTF-8"));
	response.addCookie(c);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>상세설명</h3>
<p>
   상품명 : 냉장고<br>
   제조사 : 삼싱<br>
   가격 : 200<br>
   설명 : 제조는 다른 나라에서<br>
</p>

<p> <a href="shop.jsp">돌아가기</a> </p>

</body>
</html>