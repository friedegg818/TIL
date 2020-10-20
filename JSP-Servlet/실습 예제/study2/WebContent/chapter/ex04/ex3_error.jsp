<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page errorPage="error.jsp"%>	<!-- error 발생시 이동 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<!-- name 파라미터가 없으면 에러 발생 -->
name : <%= request.getParameter("name").toUpperCase() %>

</body>
</html>