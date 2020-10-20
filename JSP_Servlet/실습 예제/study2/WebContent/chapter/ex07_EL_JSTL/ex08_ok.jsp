<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<c:forEach var="dto" items="${list}">
	${dto.num} | ${dto.name} | ${dto.subject} | ${dto.created} <br>
</c:forEach>

<hr>

<!-- varStatus -> 반복 상태를 알 수 있는 변수 
 	 index : 출력한 데이터의 순서 (0~)
	 count : 출력 횟수 (1~)
	 first : 현재 실행이 첫번째이면 true
	 last  : 현재 실행이 마지막이면 true -->
	 
<c:forEach var="dto" items="${list}" varStatus="status">
	${status.index} | ${status.count} | ${status.first} | ${status.last} |
	${dto.num} | ${dto.name} | ${dto.subject} <br>
</c:forEach>

</body>
</html>