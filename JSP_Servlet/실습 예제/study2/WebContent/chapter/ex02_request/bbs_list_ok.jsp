<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String nums = "";
	String []nm = request.getParameterValues("nums");
	if(nm!=null) {
		for(String n:nm) {
			nums += n+" ";
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> 삭제 할 게시물 => <%=nums %> </p>

</body>
</html>