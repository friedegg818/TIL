<%@page import="com.score.ScoreDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    request.setCharacterEncoding("UTF-8");

	String [] hh = request.getParameterValues("haks");
	
	ScoreDAO dao = new ScoreDAO();
	dao.deleteList(hh);
	
	response.sendRedirect("list.jsp"); 
%>
