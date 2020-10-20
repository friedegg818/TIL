<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<script type="text/javascript">
function isValidDateFormat(data) {	
	var p = /^[12][0-9]{3}[\.|\-|\/]?[0-9]{2}[\.|\-|\/]?[0-9]{2}$/;   
	if(! p.test(data)) {
		return false;
	}
	
	p = /(\.)|(\-)|(\/)/g;		// g: replace 쓸 경우 모든것을 검사
	data = data.replace(p,"");
	
	// 없는 날짜 검사 
	var y = parseInt(data.substr(0,4));
	var m = parseInt(data.substr(4,2));
	if(m<1 || m>12) {
		return false;
	}
	var d = parseInt(data.substr(6));
	var lastDay = (new Date(y,m,0)).getDate();
	
	if(d<1||d>lastDay) {
		return false;
	}	
	return true;
}
</script>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="<%=cp%>/insa/request" method="post">
	<p> 이름 : <input type="text" name="name"> </p>
	<p> 생년월일 : <input type="text" name="birth"> </p>
	<p> 전화번호 : <input type="text" name="tel"> </p>
	<p> 기본급 : <input type="text" name="sal"> </p>
	<p> 수당 : <input type="text" name="bonus"> </p>
	<p> <button type="submit"> 등록하기 </button>
</form>

</body>
</html>