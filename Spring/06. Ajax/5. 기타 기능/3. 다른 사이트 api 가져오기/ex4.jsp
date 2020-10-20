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
$(function(){		// jsonp 를 사용하여 다른 사이트 접근 
	$("#btnSend").click(function(){
		var url = "http://211.238.142.50:9090/sp3/api/user2.jsp";

		$.ajax({
			type: "get",
			url: url, 	
			dataType : "jsonp", 
			jsonp: "callback",
			success: function(data) {		
				if(data==null) {
					return false;
				}
				
				var out = "이름 : " + data.name + ", 나이 : " + data.age; 
				
				$("#resultLayout").html(out);
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