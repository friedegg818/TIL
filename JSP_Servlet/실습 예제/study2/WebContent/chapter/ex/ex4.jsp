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
	int row=10; 
	int col=5;
	int n=0;
%>

<table border="1" style="border-collapse: collapse; width: <%=col*50%>px;">
<% for(int i=1; i<=row; i++) { %>
	<tr height="30" align="center">
	
	<% for(int j=1; j<=col; j++) {
		n++;
	%>
		<td width="50"><%=n%></td>
	<% } %>
	</tr>
<% } %>
</table>



</body>
</html>