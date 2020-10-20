<%@page import="org.json.JSONObject"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("utf-8");
	
	String id = request.getParameter("id");
	String cb = request.getParameter("callback");
	
	String name = "박지송아";
	int age = 30;
	
	JSONObject job = new JSONObject();
	job.put("name", name);
	job.put("age", age);
	
	out.print(cb+"("+job.toString()+")");	
%>
