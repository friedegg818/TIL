<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.guest.GuestDAO"%>
<%
	String cp = request.getContextPath();
	request.setCharacterEncoding("utf-8");
	
	int num=Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("page");

	GuestDAO dao=new GuestDAO();
	dao.deleteGuest(num);
	
	response.sendRedirect(cp+"/guest/guest.jsp?page="+pageNum);
%>
