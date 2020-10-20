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
function fun() {
	return new Promise(function(resolve, reject) {		
		setTimeout(function(){
			resolve(1);
		}, 2000);
	})
	.then(function(result){
		console.log(result);	// 2번 출력 > 1
		return result + 10;		
	})
	.then(function(result){
		console.log(result);	// 3번 출력 > 11
		return result + 10;		
	})
	.then(function(result){		//  4번 출력 > 21 
		console.log(result);	
	});
}

fun();	
console.log("예제...");	// 1번 출력

</script>

</head>
<body>

<h3> 비동기 예제 </h3>

</body>
</html>