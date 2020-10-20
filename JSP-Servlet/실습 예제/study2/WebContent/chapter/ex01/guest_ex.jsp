<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");

	String name=request.getParameter("name");
	String content=request.getParameter("content");
	
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
* {
	margin: 0;padding: 0;
}

body {
	font-size: 14px; font-family: 맑은 고딕, 돋움;
}

a {
	color: #000; text-decoration: none;
}
a:hover, a:active {
	color: tomato; text-decoration: underline;
}

.boxTF {
	border: 1px solid #999;
	padding:3px 5px 5px;
	border-radius: 4px; 
}
.boxTA {
	border: 1px solid #999;
	padding:3px 5px;
	border-radius: 4px;
	height: 70px;
	resize: none;
}
.btn {
	color:#333;
	font-weight:500;
	background-color: #fff;
	border: 1px solid #ccc;
	padding:3px 10px 5px;
	border-radius: 4px; 
}
.btn:hover {
	border-color: #adadad;
	background-color: #e6e6e6;
	font-weight: 700; 
}

</style>

<script type="text/javascript">
function sendGuest() {
	var f = document.guestForm;
	
	if(! f.name.value) {
		f.name.focus();
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

<div style="width: 600px; margin: 30px auto; ">
	<div>
		<h3>| 방명록</h3>
	</div>
	
	<form name="guestForm" action="guest_ex.jsp" method="post">
		<table style="width: 100%; margin-top: 10px; border-spacing: 0; border-collapse: collapse;">
			<tr height="30" style="border-top: 1px solid #ccc; border-bottom: 1px solid #ccc;">
				<td align="center" width="100" bgcolor="#eeeeee">작성자</td>
				<td style="padding-left: 5px;"> <input type="text" name="name" class="boxTF"></td>
			</tr>
			<tr  style="border-bottom: 1px solid #ccc;">
				<td align="center" bgcolor="#eeeeee">내용</td>
				<td style="padding:5px 5px 2px;">
					<textarea name="content" style="width: 98%;" class="boxTA"></textarea>			
				</td>
			</tr>
			<tr height="40">
				<td colspan="2" align="right">
					<button type="button" onclick="sendGuest();" class="btn">등록하기</button>
					<button type="reset"  class="btn">다시입력</button>
				</td>
			</tr>
		</table>
	</form>
	
<% if(name!=null) { %>	
	<table style="width: 100%; margin-top: 15px; border-spacing: 0; border-collapse: collapse;">
		<tr height="30" bgcolor="#eeeeee" style="padding-left: 5px; border: 1px solid #ccc;">
			<td width="50%" style="padding-left: 5px;">
				<%=name %>
			</td>
			<td width="50%" align="right" style="padding-right: 5px;">
				2020-04-01 17:25:00
				| <a href="#">삭제</a>
			</td>
		</tr>
		<tr height="70">
			<td colspan="2" valign="top" style="padding: 5px;">
			<%=content %>
			</td>
		</tr>
	</table>
<% } %>
	
</div>

</body>
</html>