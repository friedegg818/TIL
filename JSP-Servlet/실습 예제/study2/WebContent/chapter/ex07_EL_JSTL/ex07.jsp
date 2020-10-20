<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	List<String> list = new ArrayList<>();
	list.add("서울");
	list.add("부산");
	list.add("대구");
	list.add("인천");
	list.add("광주");
	
	request.setAttribute("list", list);
%>

<jsp:forward page="ex07_ok.jsp"/>