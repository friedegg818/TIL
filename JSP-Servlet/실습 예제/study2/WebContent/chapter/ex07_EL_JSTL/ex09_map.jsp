<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	Map<String, Object> map = new HashMap<>();
	map.put("name", "이자바");
	map.put("city", "서울");
	map.put("tel", "010-1111-1111");
	
	List<Map<String, Object>> list = new ArrayList<>();
	Map<String, Object> map1 = new HashMap<>();
	map1.put("name", "고고고");
	map1.put("subject", "가가가");
	list.add(map1);
	
	map1 = new HashMap<>();
	map1.put("name", "노노노");
	map1.put("subject", "나나나");
	list.add(map1);
	
	map1 = new HashMap<>();
	map1.put("name", "도도도");
	map1.put("subject", "다다다");
	list.add(map1);
	
	request.setAttribute("map", map);
	request.setAttribute("list", list);	
%>

<jsp:forward page="ex09_ok.jsp"/>