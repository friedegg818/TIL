<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");

	String [] users = request.getParameterValues("itemRight");
	String s = "";
	if(users!=null) {
		for(String id:users) {
			s += id +" ";
		}
	}
	
	String msg = request.getParameter("msg");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> 받은 사람 | <%=s %> </p>
<p> 쪽지 내용 | <pre><%=msg %></pre> </p> 

</body>
</html>