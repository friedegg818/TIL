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

<form action="ex1_ok.jsp" method="post">
<p> 이름 : <input type="text" name="name"></p>
<p> 나이 : <input type="text" name="age"></p>
<p> 좋아하는 과목 : 
	<input type="checkbox" name="subject" value="자바"> 자바 
	<input type="checkbox" name="subject" value="스프링"> 스프링
	<input type="checkbox" name="subject" value="HTML"> HTML
	<input type="checkbox" name="subject" value="CSS"> CSS
	<input type="checkbox" name="subject" value="자바스크립트"> 자바스크립트
</p>
<p>
	<button type="submit">등록하기</button>
</p>
</form>

</body>
</html>