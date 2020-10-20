<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("utf-8");
	
	String subject = request.getParameter("subject");
	
	String s = "좋아하는 과목 - " + subject;
	
	out.print(s);
%>
