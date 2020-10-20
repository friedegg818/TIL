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

<form action = "write_ok.jsp" method="post">
	<p> 이름 : <input type="text" name="name"> </p>
	<p> 나이 : <input type="text" name="age"> </p>
	<p> 급여 : <input type="text" name="pay"> </p>
	<p> <button> 확인 </button> </p>
</form>

</body>
</html>