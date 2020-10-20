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
	String pageNum = request.getParameter("page");
	
	dto.setIpAddr(request.getRemoteAddr());
	
	dao.updateBoard(dto);
	
//	response.sendRedirect(cp+"/bbs/list.jsp?page="+pageNum);	// 리스트로 
	response.sendRedirect(cp+"/bbs/article.jsp?num="+dto.getNum()+"&page="+pageNum); 	// 게시글로 
%>