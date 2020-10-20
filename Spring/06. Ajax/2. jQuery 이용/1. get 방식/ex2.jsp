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
		var url = "ex2_ok.jsp";
		
		// AJAX-GET 방식 2
/* 		
		$.get(url, {oper:o, ...}, function(data){
		});
		에서 oper를 encodeURIComponent()로 인코딩해서 전송하면 자바측에서 oper=URLDecoder.decode(oper, "UTF-8"); 로 디코딩 해야 함 
*/		
		$.get(url, {num1:n1, num2:n2, oper:o}, function(data){		// (주소, 서버로 보내는 파라미터 값, 서버가 보내준 데이터 출력)
			$("#resultLayout").html(data);
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