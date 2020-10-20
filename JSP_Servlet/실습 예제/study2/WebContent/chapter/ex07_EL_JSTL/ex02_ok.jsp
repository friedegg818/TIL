<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="vo" class="com.user.UserVO"/>
<jsp:setProperty property="*" name="vo"/>

<%
	String s = "성인";
	if(vo.getAge()<19) {
		s = "미성년자";
	}
	
	request.setAttribute("result", s);
	request.setAttribute("vo", vo);
%>

<jsp:forward page="ex02_result.jsp"/>