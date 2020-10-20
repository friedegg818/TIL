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

<%= (3+5) %> <br>  
<%
	out.print((3+5)+"<br>");
%>
  
<p>
	<%=request == pageContext.getRequest() %>	<!-- true -->
</p>

<p> 
	<%=out == pageContext.getOut() %>
</p>

<p>
	<%=pageContext.getServletContext().getRealPath("/") %>  
</p>

<p>
	<%= page == this %>		
</p>

</body>
</html>