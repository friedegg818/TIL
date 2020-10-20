<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<% 
	Enumeration<String> e = request.getHeaderNames();

	while(e.hasMoreElements()) {
		String name = e.nextElement();
		String value = request.getHeader(name);
		out.print(name+":"+value+"<br>");
	}
%>

<p>
	이전 주소 : <%= request.getHeader("Referer") %>  
	<!-- 어디를 통해 사이트로 들어왔는지 확인. 해킹이 가능하기 때문에 100% 신뢰는 불가 -->
</p>

<p>
	유저 브라우저 및 OS : <%= request.getHeader("User-Agent") %>
</p>

</body>
</html>