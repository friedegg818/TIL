<%@page import="com.bbs.BoardDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	String cp = request.getContextPath();
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="dto" class="com.bbs.BoardDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	BoardDAO dao = new BoardDAO();
	
	dto.setIpAddr(request.getRemoteAddr());
	
	dao.insertBoard(dto);
	
	response.sendRedirect(cp+"/bbs/list.jsp");
%>