<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page isErrorPage="true" %>

<%
// IE는 자체적인 에러 메세지가 출력 된다. 이 대신에 직접 설정한 에러 페이지를 출력 하도록 설정
	response.setStatus(HttpServletResponse.SC_OK); 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> 실행중 오류 발생 </p>
<p> <%=exception.getClass().getName() %> </p>s
<p> <%=exception.toString() %> </p>
<p> <%=exception.getMessage() %> </p>

</body>
</html>