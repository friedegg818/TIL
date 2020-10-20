<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");

	// 서버로 전송된 파라미터 이름 
	Enumeration<String> e = request.getParameterNames();	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<%
	while(e.hasMoreElements()) {
		String pname = e.nextElement();
		String[] ss = request.getParameterValues(pname); 
		for(String s: ss) {
			out.print(pname+":"+s+"<br>");
		}
	}
%>

</body>
</html>