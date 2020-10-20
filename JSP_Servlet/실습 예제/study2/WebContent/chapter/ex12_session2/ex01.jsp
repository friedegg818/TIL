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

<h3> 세션 동적 원리 </h3>
<p> isNew() : <%=session.isNew()%> </p>
<hr>

<p> 쿠키 내용 </p>
<%
	Cookie[] cc = request.getCookies();
	if(cc!=null) {
		for(Cookie c: cc) {
			String name = c.getName();
			String value = c.getValue();
			out.print(name+":"+value+"<br>");
		}
	}
%>

</body>
</html>