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

$(function(){
	$("#sendBtn").click(function(){
		var tableName = $("#tableName").val().trim();
		if(! tableName) {
			return false;
		}
		
		var fn = function(data) {
			if(data.state=="false") {
				alert("테이블 생성 실패");
				return false;
			}
			location.href="<%=cp%>/table/main";
		};
		
		var url = "<%=cp%>/table/add";
		var query = "tableName="+tableName
		
		ajaxJSON(url, "post", query, fn);		
	});
});

$(function(){
	$(".dropTableButton").click(function(){		
		var tableName = $(this).attr("data-tableName");		
		var url = "<%=cp%>/table/drop";
		var query = "tableName="+tableName;
		
		var fn = function(data) {
			if(data.state=="false") {
				alert("테이블 삭제 실패");
				return false;
			}
			location.href="<%=cp%>/table/main"
		}
		
		ajaxJSON(url, "post", query, fn);		
	});
});

</script>

</head>
<body>

<h3> 게시판 테이블 관리 </h3>

<div>
	<input type="text" id="tableName" placeholder="테이블명">
	<button type="button" id="sendBtn"> 테이블 생성 </button>
</div>
<hr>

<p> 게시판 테이블 리스트 </p>
<c:forEach var="map" items="${list}" varStatus="status">
	<p> 
		${status.count} | ${map.TNAME} |
		<button type="button" class="dropTableButton" data-tableName="${map.TNAME}"> 테이블 삭제 </button>
    </p>
</c:forEach>

</body>
</html>