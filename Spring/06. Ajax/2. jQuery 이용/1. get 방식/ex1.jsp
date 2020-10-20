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
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#btnOk").click(function(){
		var query;
		query = $("form[name=myForm]").serialize();			// serialize() : 자동으로 인코딩 해 줌 
	//	query = "num1=" + $("#num1").val() + "&num2=" + $("#num2").val() + "&oper=" + encodeURIComponent($("#oper").val());		// + 는 인코딩 해주어야 함. 
		
		var url = "ex1_ok.jsp?"+query;
		
		// AJAX-GET 방식 1 
		$("#resultLayout").load(url);
	});
});
</script>
</head>
<body>

<form name="myForm">
	<input type="text" name="num1" id="num1">
	<select name="oper" id="oper">
		<option value="+">더하기</option>
		<option value="-">빼기</option>
		<option value="*">곱하기</option>
		<option value="/">나누기</option>
	</select>
	<input type="text" name="num2" id="num2">
	<button type="button" id="btnOk">확인</button>
</form>
<br>
<div id="resultLayout"></div>

</body>
</html>