<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");
%>


<jsp:useBean id="vo" class="com.calc.CalcVO"/>
<%
	// CalcVO vo = new CalcVO(); 와 유사 
%>


<jsp:setProperty property="*" name="vo"/>
<jsp:setProperty property="operator" name="vo" param="oper"/>
<%
	// * : 동일한 이름만 모두 가져와라 
		// num1, num2는 넘어가지만 oper는 넘어가지 않음 (이름이 달라서)
	// property : VO에 있는 필드명 , param : form 태그에 있는 이름 
	// vo.setNum1(Integer.parseInt(request.getParameter("num1"))); 
%>

<%
	String s="";
	switch(vo.getOperator()) {
	case "+" : s = "합 : "+ (vo.getNum1() + vo.getNum2()); break;
	case "-" : s = "차 : "+ (vo.getNum1() - vo.getNum2()); break;
	case "*" : s = "곱 : "+ vo.getNum1() * vo.getNum2(); break;
	case "/" : s = "몫 : "+ vo.getNum1() / vo.getNum2(); break;
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

<%=s %>


</body>
</html>