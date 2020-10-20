<%@page import="com.user.UserVO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("UTF-8");

	String s = (String)request.getAttribute("result");
	UserVO vo = (UserVO)request.getAttribute("vo");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>기존 방식</h3>

<p> <%=request.getParameter("name") %> </p>
<p> <%=vo.getName() %> </p>
<p> <%=vo.getAge() %> </p>
<p> <%=s %> </p>
 
</body>
</html>