<%@page import="com.bbs.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.bbs.BoardDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	BoardDAO dao = new BoardDAO();
	List<BoardDTO> list = dao.listBoard(1,100);
	request.setAttribute("list", list);	
%>

<jsp:forward page="ex08_ok.jsp"/>