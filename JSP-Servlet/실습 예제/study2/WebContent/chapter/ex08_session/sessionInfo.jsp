<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String id = session.getId(); // 세션아이디(유일)
	int interval = session.getMaxInactiveInterval(); // 세션 유지 시간 
	String subject = (String)session.getAttribute("subject");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> 세션 정보 </h3>

<p> 세션 아이디 : <%=id %> </p>
<p> 세션 유지 시간 : <%=interval/60 %> 분 </p>
<p> subject : <%=subject %> </p>
<p> EL을 이용한 세션 정보 가져오기 : ${sessionScope.score} </p>

<p> <a href="ex01.jsp">돌아가기</a> </p>

</body>
</html>