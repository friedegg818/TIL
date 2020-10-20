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
<script type="text/javascript">

function createXMLHttpRequest() {
	var req = null;
	
	if(window.XMLHttpRequest) {		// IE 7 이상, Non-MS 브라우저 
		req = new XMLHttpRequest();	// AJAX 객체 
	} else if(window.ActiveXObject) {
		req = new ActiveXObject("Msxml2.XMLHTTP");
	}
	
	return req;
}

var httpReq = null;

function send() {
	var query; 
	var n1 = document.getElementById("num1").value;
	var n2 = document.getElementById("num2").value;
	var o = document.getElementById("oper").value;
	
	query = "num1="+n1+"&num2="+n2+"&oper="+o;
	var url = "ex3_ok.jsp";
	
	// AJAX 객체 생성
	httpReq = createXMLHttpRequest();
	// 서버에서 처리하고 결과를 전송 할 자바스크립트 함수 지정 
	httpReq.onreadystatechange = callback;
	
	// POST 방식 
	httpReq.open("POST", url, true);	
	httpReq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");		// 이게 있어야 데이터를 넘겨줌 
	httpReq.send(query);	
}

function callback() {
	/* console.log(httpReq.readyState, httpReq.status); */
	if(httpReq.readyState==4) {		// 요청상태 (4:모든 요청 응답완료)
		if(httpReq.status==200) {	// 서버로부터의 상태코드 (200:OK)
			printData(); 
		}
	}
}

function printData() {
	var resultLayout = document.getElementById("resultLayout");
	var s = httpReq.responseText;
	resultLayout.innerHTML = s;
}

</script>
</head>
<body>

<form>
	<input type="text" id="num1">
	<select id="oper">
		<option value="add"> 더하기 </option>
		<option value="sub"> 빼기 </option>
		<option value="mul"> 곱하기 </option>
		<option value="div"> 나누기 </option>
	</select>	
	<input type="text" id="num2">
	<button type="button" onclick="send()"> 확인 </button>
</form>
<hr>
<div id="resultLayout"></div>

</body>
</html>