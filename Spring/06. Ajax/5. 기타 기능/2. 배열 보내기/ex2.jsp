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
	$("#btnSend").click(function(){
		var url = "ex2_ok.jsp";
		var arr = [];
		arr.push("java"); 
		arr.push("oracle");
		arr.push("spring");
		
		$.ajax({
			type: "post",
			url: url, 
			data: {subject:arr}, 
			traditional: true,  		// 배열을 직렬화함. subject=java&subject=oracle&subject=spring 처럼 
			success: function(data) {		
				$("#resultLayout").html(data);
			}, 
			error: function(e) {
				console.log(e.responseText);
			}
		});
		
	});
});

</script>
</head>
<body>

<div>	
	<p> <button type="button" id="btnSend"> 확인 </button>
</div>
<hr>
<div id="resultLayout"></div>
</body>
</html>