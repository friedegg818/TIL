<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("userId");
	String pwd = request.getParameter("userPwd");
/* 	String pwd1 = request.getParameter("userPwd1"); */
	String name = request.getParameter("userName");
	String email = request.getParameter("email1") + "@" + request.getParameter("email2");
	String tel = request.getParameter("tel1") + "-" + request.getParameter("tel2") + "-" + request.getParameter("tel3");
	String zip = request.getParameter("zip");
	String addr = request.getParameter("addr1") + "&nbsp;" + request.getParameter("addr2");
	String job = request.getParameter("job");	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<div>
	<h3>| 회원정보</h3>
		<p> 아이디 : <%=id %> </p>
		<p> 비밀번호 : <%=pwd %> </p>
		<p> 이름 : <%=name %> </p>
		<p> 이메일 : <%=email %> </p>
		<p> 전화번호 : <%=tel %> </p>
		<p> 우편번호 : <%=zip %> </p>
		<p> 주소 : <%=addr %> </p>
		<p> 직업 : <%=job %> </p>
</div>


</body>
</html>