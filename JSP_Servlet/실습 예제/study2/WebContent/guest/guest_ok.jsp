<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.guest.GuestDAO"%>
<%
	String cp = request.getContextPath();
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="dto" class="com.guest.GuestDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	GuestDAO dao=new GuestDAO();
	dao.insertGuest(dto);
	
	response.sendRedirect(cp+"/guest/guest.jsp");
%>
