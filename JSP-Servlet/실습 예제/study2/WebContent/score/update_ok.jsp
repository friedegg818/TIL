<%@page import="com.score.ScoreDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="dto" class="com.score.ScoreDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	ScoreDAO dao = new ScoreDAO();
	try {
		dao.updateScore(dto);
	} catch(Exception e) {
		response.sendRedirect("write.jsp?error");
		return;
	}
	
	response.sendRedirect("list.jsp");
	// 리다이렉트 : insert, update, delete, 로그인, 로그아웃 후에 일반적으로 사용 
%>