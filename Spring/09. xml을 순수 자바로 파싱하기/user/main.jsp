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

<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type,
		url:url,
		data:query,
		dataType:"json",
		success:function(data) {
			fn(data);
		},
		error:function(e){
			console.log(e.responseText);
		}
	});
}

function ajaxXML(url, type, query, fn) {
	$.ajax({
		type:type,
		url:url,
		data:query,
		dataType:"xml",
		success:function(data) {
			fn(data);
		},
		error:function(e){
			console.log(e.responseText);
		}
	});
}

$(function(){		// 자바로 파싱
	$("#btnSend").click(function(){
		var url = "<%=cp%>/user/list";
		var query = {temp:new Date().getTime()};		// 넘기는 파라미터가 없어서 그냥 시간 보내는 것
		
		var fn = function(data) {
			var out = ""; 
			var dataCount = data.dataCount;
			
			out = "개수 : " + dataCount;
			$.each(data.list, function(index, item){
				var num = item.num;
				var name = item.name;
				var content = item.content;
				var created = item.created;
				
				out += "<br> name : " + name + ", content : " + content + ", created : " + created + ", num : " + num;
			});
			
			$("#resultLayout").html(out);
		};
		
		ajaxJSON(url, "get", query, fn);
	});
});

$(function(){			// jquery로 파싱 
	$("#btnSend2").click(function(){
		var url = "<%=cp%>/user/list2";
		var query = {temp:new Date().getTime()};	
		
		var fn = function(data) {			
			var out = "";
			var dataCount = $(data).find("dataCount").text();
			out = "개수 : " + dataCount;
			
			$(data).find("record").each(function(){
				var record = $(this);
				var num = record.attr("num");
				var name = record.find("name").text();
				var content = record.find("content").text();
				var created = record.find("created").text();
				
				out += "<br> 이름 : " + name + ", 내용 : " + content + ", 날짜 : " + created + ", 번호 : " + num;				
			});
			
			$("#resultLayout").html(out);
		};
		
		ajaxXML(url, "get", query, fn);
		
	});
});

</script>

</head>
<body>

<div>
	<button type="button" id="btnSend">XML을 JSON으로 받아오기</button>
	<button type="button" id="btnSend2">XML 받아오기</button>
</div>
<hr>
<div id="resultLayout"></div>

</body>
</html>