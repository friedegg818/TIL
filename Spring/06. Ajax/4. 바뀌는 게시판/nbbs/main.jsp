<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>spring</title>

<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<style type="text/css">
.board-container{
	width: 700px;
	margin:30px auto;
}

.board-container .title {
    font-weight: bold;
    font-size:15px;
    margin-bottom:10px;
    font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.form.js"></script>		<!-- 있어야 FormData 사용 가능  -->

<script type="text/javascript">

// 전역변수 
var pageNo=1;
var condition="all";
var keyword="";

function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	    }
	    ,error:function(jqXHR) {
	    	console.log(jqXHR.responseText);
	    }
	});
}

function ajaxFileJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,processData:false	// file 전송시 필수. 서버로 전송 할 때 쿼리 문자열로 변환 여부
		,contentType:false  // file 전송시 필수. 서버에 전송 할 데이터 타입을 기본으로 사용하지 않고 이진 데이터로 전송
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	    }
	    ,error:function(jqXHR) {
	    	console.log(jqXHR.responseText);
	    }
	});
}

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			if($.trim(data)=="error") {
				listPage(pageNo);
				return;
			}
			$(selector).html(data);
		}
		,beforeSend:function(jqXHR) {
	    }
	    ,error:function(jqXHR) {
	    	console.log(jqXHR.responseText);
	    }
	});
}

$(function(){
	listPage(1);	
});

// 리스트 
function listPage(page) {
	pageNo = page;
	
	var url = "<%=cp%>/nbbs/list";
	var query = "pageNo=" + page;
	if(keyword) {
		query = "&condition=" + condition + "&keyword=" + encodeURIComponent(keyword);
	}
	
	vid = "#board-body";
	ajaxHTML(url, "get", query, vid);
}

// 새로고침 
function reloadBoard() {
	condition = "all";
	keyword ="";
	
	listPage(1); 
}

// 검색 
function searchList() {
	condition = $("#condition").val();
	keyword = $("#keyword").val();
	listPage(1);
}

// 글쓰기 폼 
function insertBoard() {	
	var url = "<%=cp%>/nbbs/created";
	$("#board-body").load(url);
}

// 글 등록 및 수정 완료 
function sendBoard(mode) {
	var f = document.boardForm;
	if(! f.subject.value) {
		f.subject.focus();
		return;
	}
	
	if(! f.name.value) {
		f.name.focus();
		return;
	}
	
	if(! f.content.value) {
		f.content.focus();
		return;
	}
	
	if(! f.pwd.value) {
		f.pwd.focus();
		return;
	}
	
	condition = "all";
	keyword = "";
	if(mode=="") {
		pageNo=1;
	}
	
	var url = "<%=cp%>/nbbs/" + mode;
	// var query = $("form[name=boardForm]").serialize(); // 파일 전송 불가 
	var query = new FormData(f);   // IE10 이상 
	
	var fn = function(data) {
		listPage(pageNo);		
	};
	ajaxFileJSON(url, "post", query, fn);
}

// 글 보기 
function articleBoard(num) {
	var url = "<%=cp%>/nbbs/article";
	var query = "num=" + num;
	if(keyword) {
		query += "&condition=" + condition + "&keyword=" + URIComponent(keyword);
	}
	var vid="#board-body";
	ajaxHTML(url, "get", query, vid);
}

// 수정 폼
function updateBoard(num) {
	var url = "<%=cp%>/nbbs/update";
	var query = "num="+num;
	var vid = "#board-body";
	ajaxHTML(url, "get", query, vid);
}

// 수정 - 파일 삭제 
function deleteFile(num) {
	var url = "<%=cp%>/nbbs/deleteFile";
	var query = "num="+num;
	
	var fn = function(data) {
		$("#uploadFileInfo").remove();
		$("form input[name=saveFilename]").val("");
		$("form input[name=originalFilename]").val("");
	};
	ajaxJSON(url, "post", query, fn);
}

 // 삭제
function deleteBoard(num) {
	var url = "<%=cp%>/nbbs/delete";
	var query = "num="+num;
	
	if(! confirm("게시글을 삭제 하시겠습니까?")) {
		return;
	}
	
	var fn = function(data) {		
		listPage(pageNo);
	};
	ajaxJSON(url, "post", query, fn);
} 
 
</script>

</head>

<body>
<div class="board-container">
	<div id="board-header">
		<table style="width: 100%; border-spacing: 0px;">
			<tr height="45">
				<td align="left" class="title">
					<h3><span>|</span> 게시판</h3>
				</td>
			</tr>
		</table>
	</div>
	<div id="board-body"></div>
 </div>
</body>

</html>