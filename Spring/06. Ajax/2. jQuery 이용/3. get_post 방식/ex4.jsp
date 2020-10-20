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
		var n1 = $("#num1").val();
		var n2 = $("#num2").val();
		var o = $("#oper").val();
		var url = "ex4_ok.jsp";
		
		// AJAX-$.ajax() 함수 
		$.ajax({
			url:url,
			type:"post",
			data:{num1:n1, num2:n2, oper:o},
			success:function(data) {
				$("#resultLayout").html(data);
			},
			error:function(e) { 
				console.log(e.responseText);
			}
		});		
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