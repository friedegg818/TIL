<%@ page contentType="text/html; charset=UTF-8" %>
<%
	// 1~100까지 합 
	int s=0;
	for(int n=1; n<=100; n++) {
	 s+=n;
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

<!-- HTML 주석 : 클라이언트 소스로 전송 됨 -->

<%-- JSP 주석 : 전송되지 않음(권장) --%>

<p> 결과 : <b style="color: blue;"> <%=s%> </b> </p>

</body>
</html>