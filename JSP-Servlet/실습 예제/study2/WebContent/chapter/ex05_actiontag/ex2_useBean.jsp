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

<form action="ex2_ok.jsp" method="post">
	<p> 수1 : <input type="text" name="num1"></p>
	<p> 
		<select name="oper">
			<option value="+">더하기</option>
			<option value="-">빼기</option>
			<option value="*">곱하기</option>
			<option value="/">나누기</option>		
		</select>
	</p>
	<p> 수2 : <input type="text" name="num2"> </p>
	<p> <input type="submit" value="확인"></p>
</form>

</body>
</html>