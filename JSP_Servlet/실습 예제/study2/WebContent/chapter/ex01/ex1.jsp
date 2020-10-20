<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<!-- GET - form 태그 이용한 파라미터 전송 / method를 입력하지 않으면 기본으로 get -->

<form action="ex1_ok.jsp" method="get">						
	<p> 이름 : <input type="text" name="name"></p>
	<p> 나이 : <input type="text" name="age"></p>
	<p>
		<button>보내기</button>
		<button type="submit">보내기</button>
		<input type="submit" value="보내기">
	</p>
</form>

</body>
</html>