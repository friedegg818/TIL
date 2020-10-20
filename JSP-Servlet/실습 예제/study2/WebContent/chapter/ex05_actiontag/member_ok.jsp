<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="dto" class="com.member.MemberDTO"/>
<jsp:setProperty property="*" name="dto"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> 아이디 | <%=dto.getUserId() %> </p> 
<p> 비밀번호 | <%=dto.getUserPwd() %> </p>
<p> 이름 | <%=dto.getUserName() %> </p>
<p> 생년월일 | <%=dto.getBirth() %> </p>
<p> 이메일 | <%=dto.getEmail1()+"@"+dto.getEmail2() %> </p>
<p> 전화번호 | <%=dto.getTel1()+"-"+dto.getTel2()+"-"+dto.getTel3() %> </p>
<p> 우편번호 | <%=dto.getZip() %> </p>
<p> 주소 | <%=dto.getAddr1()+" "+dto.getAddr2() %> </p>
<p> 직업 | <%=dto.getJob() %> </p>

</body>
</html>