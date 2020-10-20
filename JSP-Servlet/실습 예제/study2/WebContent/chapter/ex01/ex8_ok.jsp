<%@page import="java.net.URLDecoder"%>
<%@page import="javax.activation.URLDataSource"%>
<%@page import="java.io.InputStream"%>
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
	out.println("method : " + request.getMethod()+"<br><hr>");
	out.println("QueryString(get 방식 파라미터): " + request.getQueryString() + "<br><hr>");
	
	out.println("request로 넣어온 header 영역...<br>");
	Enumeration<String> e = request.getHeaderNames();
	while(e.hasMoreElements()) {
		String key = e.nextElement();
		String value = request.getHeader(key);
		out.println(key+":"+value+"<br>");
	}
	out.println("<hr>");
	
	out.println("request로 넘어온 body 영역(POST 방식 파라미터)...<br>");		/* get 방식은 넘어오지 않음 */
	InputStream is = request.getInputStream();
	byte[]bb = new byte[1024];
	int size;
	String str;
	
	while((size = is.read(bb))!=-1) {
		str = new String(bb, 0, size);
		out.println("디코딩 전 : "+str+"<br>");
		str = URLDecoder.decode(str,"UTF-8");
		out.println("디코딩 후 : "+str+"<br>");
	}
%>


</body>
</html>