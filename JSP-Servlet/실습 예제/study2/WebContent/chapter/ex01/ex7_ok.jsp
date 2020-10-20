<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	String proto = request.getProtocol();
	String scheme = request.getScheme();
	String serverName = request.getServerName();
	int port = request.getServerPort();
	String cp = request.getContextPath();
	String url = request.getRequestURL().toString();
	String uri = request.getRequestURI();
	String query = request.getQueryString();
	String addr = request.getRemoteAddr();
	String method = request.getMethod();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> request : 클라이언트의 요청을 담고 있는 객체 </h3>

<p> 프로토콜 : <%=proto %> </p>
<p> 스킴 : <%=scheme %> </p>
<p> 서버이름 : <%=serverName %> </p>
<p> 포트번호 : <%=port %> </p>
<p> 컨텍스트패스 : <%=cp %> </p>    <!--  프로젝트명  -->
<p> URL : <%=url %> </p>
<p> URI : <%=uri %> </p>
<p> QueryString : <%=query %> </p>
<p> 클라이언트 IP : <%=addr %> </p>
<p> 메소드 : <%=method %> </p>

</body>
</html>