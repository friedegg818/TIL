<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String chks = "";
	String []ck = request.getParameterValues("chks");
	if(ck!=null) {
		for(String c:ck) {
			chks += c+" ";
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
<p> 선택한 좌석 => <%=chks %> </p>

</body>
</html>