<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp=request.getContextPath();
	
	String name = request.getParameter("name");
	String content = request.getParameter("content");
	
	JSONObject job = new JSONObject();
	job.put("count", 5);
	
	JSONArray jarr = new JSONArray();
	for(int n=1; n<=5; n++) {
		JSONObject ob = new JSONObject();
		ob.put("num", n);
		ob.put("name", (name)+n);
		ob.put("content", (content)+n);
		
		jarr.put(ob); 
	}
	job.put("list", jarr); 
	
	out.print(job.toString());
%>
