<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");

	/* Parameter의 return type : String => 무엇을 보내든 문자열로 받는다 */

	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String score = request.getParameter("score");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> 이름 : <%=name %> </p>
<p> 과목 : <%=subject %> </p>
<p> 점수 : <%=score %> </p>

</body>
</html>