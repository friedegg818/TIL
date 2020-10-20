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
		// 서로 다른 도메인은 ajax를 이용하여 접근 할 수 없다.
		var url = "http://211.238.142.50:9090/sp3/api/user.jsp";

		$.ajax({
			type: "get",
			url: url, 	
			headers: {"Access-Control-Allow-Origin":"*"},
			dataType : "json", 
			success: function(data) {		
				var out = "좋아하는 과목 : " + data.subject;
				
				$("#resultLayout").html(out);
			}, 
		/* 	beforeSend: function(xhr) {
				xhr.setRequestHeader("Access-Control-Allow-Origin","*");
			}, */
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