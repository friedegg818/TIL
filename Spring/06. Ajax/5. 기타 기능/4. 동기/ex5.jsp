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
		var url = "ex5_ok.jsp";
		var q = "subject=java";
		

		$.ajax({
			type: "post",
			url: url,
			data: q,
			async: false, // 동기. 기본은 비동기 (true)
			success: function(data) {			
				$("#resultLayout").html(data);	// 1)
			}, 
			error: function(e) {
				console.log(e.responseText);
			}
		});
		
		$("#resultLayout").html("출력...");	// 2)
		
		// 비동기는(ajax 기본) 2번이 먼저 실행되고 1번이 실행 되므로 2번 내용이 출력 되지 않음 
		// 동기는 1번이 먼저 실행되고 2번이 실행 된다.
		
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