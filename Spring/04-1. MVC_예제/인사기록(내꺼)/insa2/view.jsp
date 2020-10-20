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
</head>
<body>

<p> 이름 : ${dto.name} </p>
<p> 생년월일 : ${dto.birth} </p>
<p> 띠 : ${ani} </p>
<p> 나이 : ${age} </p>
<p> 전화번호 : ${dto.tel} </p>
<p> 기본급 : 
	<fmt:formatNumber value="${dto.sal}" pattern="\#,###" />
</p>
<p> 수당 : 
	<fmt:formatNumber value="${dto.bonus}" pattern="\#,###" />
</p>
<p> 세금 : 
	<fmt:formatNumber value="${tax}" pattern="\#,###" />
</p>
<p> 실급여 : 
	<fmt:formatNumber value="${pay}" pattern="\#,###" />
</p>

</body>
</html>