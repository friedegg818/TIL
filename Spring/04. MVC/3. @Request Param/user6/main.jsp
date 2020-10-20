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

<p> <a href="<%=cp%>/user6/request"> 확인 1 </a> </p>
<p> <a href="<%=cp%>/user6/request?age=20"> 확인 2 </a> </p>
<p> <a href="<%=cp%>/user6/request?age=20&gender=f"> 확인 3 </a> </p>

</body>
</html>