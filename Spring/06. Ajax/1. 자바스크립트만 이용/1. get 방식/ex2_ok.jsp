<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("UTF-8"); 
	
	int num1 = Integer.parseInt(request.getParameter("num1"));
	int num2 = Integer.parseInt(request.getParameter("num2"));
	String oper = request.getParameter("oper");
	
	String s = "";
	if(oper.equals("add")) {
		s = "합 : " + (num1 + num2);
	} else if(oper.equals("sub")) {
		s = "차 : " + (num1 - num2);
	} else if(oper.equals("mul")) {
		s = "곱 : " + (num1 * num2);
	} else if(oper.equals("div")) {
		s = "몫 : " + (num1 / num2);
	}	
%>

<p> 수 : <%=num1%>, <%=num2%> </p>
<p> <%=s%> </p>

