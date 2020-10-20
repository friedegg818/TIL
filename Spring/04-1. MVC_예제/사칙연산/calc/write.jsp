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

<form action="<%=cp%>/calc/request" method="post">
	<p> 첫번째 수: <input type="text" name="num1">
	 <select name="operator">
			<option value="+"> + </option> 
			<option value="-"> - </option>
			<option value="*"> * </option>
			<option value="/"> / </option>
		</select>
	 두번째 수 : <input type="text" name="num2"> </p>
	<p> 
		<button type="submit"> 확인 </button>
	</p>
</form>

</body>
</html>