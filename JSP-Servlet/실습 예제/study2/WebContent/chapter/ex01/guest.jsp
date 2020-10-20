<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("UTF-8");

	String user = request.getParameter("user");
	String content = request.getParameter("content");
	
	if(content!=null) {
		content=content.replaceAll("\n", "<br>");
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

#layout {
	width: 600px;
	margin: 30px auto;
}

.guest {
	width: 100%;
	margin-top: 10px;
	border-spacing: 0;
	border-collapse: collapse;
}

.id {
	height: 40px;
	border-top: 1px solid gray;
	border-bottom: 1px solid gray;
}

.title {
	width: 20%;
	font-size: 13px;
	padding: 5px;
	background: #DCEBFF;
	text-align: center;
}

.memo {
	width: 80%;
	padding: 10px;
	text-align: letf;
}

.enter {
	border: 1px solid #d2d2d2;
	border-radius: 5px;
}

.btn {
	background: white;
	height: 25px;
	border: 1px solid #d2d2d2;
	border-radius: 5px;
}	

.print {
	height: 30px;
	border-top: 1px solid gray;
	border-bottom: 1px solid gray;
	background: #DCEBFF; font-size: 13px;	
}

.print2 {
	padding-left: 10px;
	padding-top: 5px;
	padding-bottom: 5px;
}

</style>

<script type="text/javascript">
function send() {
	var f = document.guestForm;
	
	if(! f.user.value) {
		f.user.focus();
		return;
	}
	
	if(! f.content.value) {
		f.content.focus();
		return;
	}
	
	f.submit();	
}

</script>

</head>
<body>

<div id="layout">
<form name="guestForm" action="guest.jsp" method="post">
	<h4> | 방명록 </h4>
	<table class="guest">
		<tr class="id">
			<td class="title">작성자</td>
			<td class="memo"><input class="enter" type="text" name="user" style="height: 25px;"></td>
		</tr>
		<tr class="id">
			<td class="title">내용</td>
			<td class="memo"><textarea class="enter" name="content" style="width: 95%; height: 80px;"></textarea></td>
		</tr>	
		<tr>			
			<td colspan="2" class="memo" style="text-align: right;">
				<button class="btn" type="button" onclick="send();">등록하기</button>
				<button class="btn" type="reset">다시입력</button></td>
		</tr>
	</table>
</form>

	<table class="guest">
		<tr class="print">
			<td class="print2"><%=user %></td>
			<td style="text-align: right; padding-right: 5px;">2020-04-28 17:50:55</td>
		</tr>
		<tr class="print" style="background: white;">
			<td colspan="2" class="print2"><%=content %></td>
		</tr>	
	</table>

</div>

</body>
</html>