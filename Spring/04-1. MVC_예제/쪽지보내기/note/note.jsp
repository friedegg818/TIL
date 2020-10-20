<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
*{
	margin: 0px; padding: 0px;
}
body {
    font-size: 14px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
    box-sizing: border-box;  /* padding과 border는 크기에 포함되지 않음 */	
}
a{
	color: #000000;
	text-decoration: none;
	cursor: pointer;
}
a:active, a:hover {
	text-decoration: underline;
	color: tomato;
}
.btn {
    color:#333333;
    font-weight:500;
    border:1px solid #cccccc;
    background-color:#fff;
    text-align:center;
    cursor:pointer;
    padding:3px 10px 5px;
    border-radius:4px;
}
.btn:active, .btn:focus, .btn:hover {
	 background-color:#e6e6e6;
	 border-color: #adadad;
	 color: #333333;
}
.boxTF {
    border:1px solid #999999;
    padding:4px 5px 5px;
    border-radius:4px;
    background-color:#ffffff;
}
.selectField {
    border:1px solid #999999;
    padding:2px 5px 6px;
    border-radius:4px;
    font-size: 12px;
}
.boxTA {
    border:1px solid #999999;
    height:150px;
    padding:3px 5px;
    border-radius:4px;
    background-color:#ffffff;
}
.title {
	width:100%;
	height:45px;
	line-height:45px;
	text-align:left;
	font-weight: bold;
	font-size:15px;
}
</style>

<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<script type="text/javascript">
$(function(){
	<c:forEach var="dto" items="${listFriend}">
		$("#itemLeft").append("<option value='${dto.userId}'>${dto.userName}</option>");
	</c:forEach>
});

$(function() {
	$("#btnRight").click(function() {
		$("#itemLeft option:selected").each(function() {
			$(this).appendTo("#itemRight");
		});
	});
	
	$("#btnAllRight").click(function() {
		$("#itemLeft option").each(function() {
			$(this).appendTo("#itemRight");
		});
	});
	
	$("#btnLeft").click(function() {
		$("#itemRight option:selected").each(function() {
			$(this).appendTo("#itemLeft");
		});
	});
	
	$("#btnAllLeft").click(function() {
		$("#itemRight option").each(function() {
			$(this).appendTo("#itemLeft");
		});
	});
});


function sendOk() {
	if($("#itemRight option").length==0) {
		alert("받는 사람을 추가하세요");
		return;
	}	
	
	$("#itemRight option").prop("selected", true);
	
	var f = document.noteForm;
	if(! f.msg.value) {
		f.msg.focus();
		return;
	}
	
	f.action="<%=cp%>/note/request";
	
	f.submit();
}

</script>

</head>
<body>

<div style="width: 400px; margin: 30px auto 0px;">

	<div class="title">
	   <h3><span>|</span> 쪽지 보내기</h3>
	</div>

	<form name="noteForm" method="post">
	<table style="width: 100%; margin: 10px auto 0;padding: 5px 5px 0;">
	<tr height="25">
	    <td width="150"><span>친구목록</span></td>
	    <td width="100">&nbsp;</td>
	    <td width="150"><span>받는사람</span></td>
	</tr>
	
	<tr>
	    <td align="center" style="padding: 3px;">
	        <select name="itemLeft" id="itemLeft" multiple="multiple" class="selectField" style="width:130px; height:120px;"></select>
	    </td>
	    <td align="center">
		    <button type="button" class="btn" id="btnRight" style="display:block; width:80px;"> &gt; </button>
		    <button type="button" class="btn" id="btnAllRight" style="display:block;width:80px;"> &gt;&gt; </button>
		    <button type="button" class="btn" id="btnLeft" style="display:block;width:80px;"> &lt; </button>
		    <button type="button" class="btn" id="btnAllLeft" style="display:block;width:80px;"> &lt;&lt; </button>
	    </td>
	    <td align="center" style="padding: 2px;">
	        <select name="receiver" id="itemRight" multiple="multiple" class="selectField" style="width:130px; height:120px;">
	        </select>
	    </td>
	</tr>
	<tr height="25">
	    <td colspan="3" align="left" style="padding-top: 5px;">
	       <span>메시지</span>
	    </td>
	</tr>
	<tr>
	    <td colspan="3" style="padding: 3px;">
	        <textarea rows="5" cols="60" name="msg" class="boxTA" style="height:60px; width: 95%;"></textarea>
	    </td>
	</tr>
	</table>
	
	<table style="width: 100%;">
	<tr height="30">
	    <td align="right" style="padding-right: 4%;">
	        <button type="button" class="btn" onclick="sendOk();"> 쪽지보내기 </button>
	    </td>
	</tr>
	</table>
	</form> 

</div>

</body>
</html>