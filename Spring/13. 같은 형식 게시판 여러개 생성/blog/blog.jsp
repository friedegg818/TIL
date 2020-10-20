<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
ul {
	margin: 0; padding: 0; list-style: none; 
}

li {
	margin: 0; padding: 0;
}
</style>
</head>
<body>

<h3> 블로그 리스트 </h3>
<div>
	<ul>
		<c:forEach var="dto" items="${list}">
			<li> <a href="<%=cp%>/blog/${dto.userIdx}/main"> ${dto.title} 블로그 </a> </li>
		</c:forEach>
	</ul>
</div>


</body>
</html>