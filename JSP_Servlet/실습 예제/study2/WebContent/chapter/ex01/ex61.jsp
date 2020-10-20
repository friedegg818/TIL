<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<script type="text/javascript">
function check() {
	var f = document.myForm; 
	
	if(!f.name.value.trim()) {
		f.name.focus();
		return false;
	}
	
	return true;
}
</script>


</head>
<body>

<h3>서버로 전송 : text 객체가 하나이면 엔터를 누르면 서버로 submit </h3>

<form name="myForm" action="ex6_ok.jsp" method="post" onsubmit="return check();">
	<p> 이름 : <input type="text" name="name"></p>
</form>

</body>
</html>