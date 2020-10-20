<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<c:if test="${empty sessionScope.id}">
	 <form action="login_ok.jsp" method="post">
	 <p>
		아이디 : <input type="text" name="id"><br>
		패스워드 : <input type="password" name="pwd">
		<button type="submit">로그인</button>
		<br>
		${msg}
	 </p>
	 </form>
</c:if>

<c:if test="${not empty sessionScope.id}">
	 <p>
	 ${sessionScope.name} 님 안녕하세요 ͡~ ͜ʖ ͡°  | 
		<a href="logout.jsp">로그아웃</a>
	 </p>
</c:if>
 
 <p>
 	<a href="sessionSet.jsp">세션 정보 설정</a> |
 	<a href="sessionInfo.jsp">세션 정보 확인</a> |
 	<a href="removeInfo.jsp">세션 정보 삭제</a>
 </p>

</body>
</html>