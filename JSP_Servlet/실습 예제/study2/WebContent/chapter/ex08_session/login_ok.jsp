<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	if(id.equals("test") && pwd.equals("test")) {
		session.setAttribute("id", id);
		session.setAttribute("name", "박지송아");
		response.sendRedirect("ex1.jsp");
		return;
	}
	
	request.setAttribute("msg", "아이디 또는 패스워드를 정확히 입력하세요.");
%>

<jsp:forward page="ex01.jsp"/>
