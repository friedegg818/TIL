<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%!
	// 선언부 - 필드, 메소드 정의 영역 
	public int sum(int n) {
	 	int s=0;
	 	for(int i=1; i<=n; i++) {
	 		s+=n;
	 	}
	 	return s;
	}

	public int x=0;	
%>

<%
	// 스크립트 릿 - 메소드(서비스) 속에 들어오는 소스
	int s;
	s = sum(50);
	
	int y=0;
	
	x++;
	y++; 
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> 결과 : <%=s%> </p>
<p> x : <%=x%> </p>
<p> y : <%=y%> </p>


</body>
</html>