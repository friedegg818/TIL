<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	String method = request.getMethod();

	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	String state = "성인";
	if(age<19)
		state = "미성년자";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> 파라미터 받기 </h3>

<p> 이름 : <%=name %> </p>
<p> 나이 : <%=age %> </p>
<p> <%=state %> </p>

</body>
</html>