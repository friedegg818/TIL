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
		var q = "name="+$("#name").val()+"&content="+$("#content").val();
		var url = "ex1_ok.jsp?"+q;
		
		var out = "";
		$.getJSON(url, function(data){			
		
			var count = data.count;
			out += "count:" + count + "<br>";
/* 		
			for(var i=0; i<data.list.length; i++) {
				var num = data.list[i].num;
				var name = data.list[i].name;
				var content = data.list[i].content;
				
				out +="num:" + num + " ,name:" + name + " ,content:" + content+ "<br>";
			}
 */			
 		$.each(data.list, function(index, item) {
		    var num = item.num;
		    var name = item.name;
		    var content = item.content;
		    
		    out +="num:" + num + " ,name:" + name + " ,content:" + content+ "<br>";			
 		
		    $("#resultLayout").html(out);
		});		
	});
});

</script>
</head>
<body>

<div>
	<p> 이름 : <input type="text" id="name"> </p>
	<p> 내용 : <textarea id="content" rows="5" cols="50"></textarea> </p>
	<p> <button type="button" id="btnSend"> 등록하기 </button>
</div>
<hr>
<div id="resultLayout"></div>
</body>
</html>