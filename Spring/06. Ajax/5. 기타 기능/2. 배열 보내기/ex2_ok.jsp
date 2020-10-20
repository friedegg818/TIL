<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("utf-8");
	
	String []ss = request.getParameterValues("subject");
	
	String s = "좋아하는 과목 >> ";
	if(ss!=null) {
		for(String a : ss) {
			s += a + " : ";
		}
	}
	
	out.print(s);
%>
