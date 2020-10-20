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
new Promise(function(resolve, reject) {		// resolve: 성공시, reject: 실패시 
	setTimeout(function(){
		resolve("비동기");
	}, 2000);
})

.then(function(result){
		console.log(result);
});
	
console.log("예제...");

</script>

</head>
<body>

<h3> 비동기 예제 </h3>

</body>
</html>