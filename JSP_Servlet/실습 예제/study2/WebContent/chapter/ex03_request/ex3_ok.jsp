<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String s;	// try~catch 블럭 안에서 선언 된 변수는 밖에서는 사용 할 수 없으므로 추후에 결과 출력을 위해 바깥에서 정의 해 줌 

	try {
		int num1 = Integer.parseInt(request.getParameter("num1"));
		int num2 = Integer.parseInt(request.getParameter("num2"));
		String oper = request.getParameter("oper");				
		s = num1 + "+" + num2 + "=";
		
		switch(oper) {
		case "+" : s+=(num1+num2); break;
		case "-" : s+=(num1-num2); break;
		case "*" : s+=(num1*num2); break;
		case "/" : s+=(num1/num2); break;
		} 		
	} catch(Exception e) {
		s = "자료 입력이 잘못 되었거나 시스템 문제 발생";
		e.printStackTrace(); 
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

<p> <%=s %> </p>

</body>
</html>