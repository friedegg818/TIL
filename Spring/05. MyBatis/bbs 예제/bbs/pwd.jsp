<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
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
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

body {
	font-size: 14px;
	font-family: "Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
}

a {
	color: #000000;
	text-decoration: none;
	cursor: pointer;
}

a:active, a:hover {
	text-decoration: underline;
	color: tomato;
}

textarea:focus, input:focus {
	outline: none;
}

.btn {
	color: #333333;
	font-weight: 500;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	border: 1px solid #cccccc;
	background-color: #ffffff;
	text-align: center;
	cursor: pointer;
	padding: 3px 10px 5px;
	border-radius: 4px;
}

.btn:active, .btn:focus, .btn:hover {
	background-color: #e6e6e6;
	border-color: #adadad;
	color: #333333;
}

.boxTF {
	border: 1px solid #999999;
	padding: 3px 5px 5px;
	border-radius: 4px;
	background-color: #ffffff;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}

.selectField {
	border: 1px solid #999999;
	padding: 2px 5px 4px;
	border-radius: 4px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}

.title {
	font-weight: bold;
	font-size: 16px;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
}
</style>
</head>

<body>
	<div style="width: 300px; margin: 100px auto 0px;">
		<form method="post" action="<%=cp%>/bbs/pwd">
			<table style="width: 100%; background: #cccccc; border-spacing: 1px;">
				<tr align="center">
					<td height="40" bgcolor="#E6E4E6" class="title">
						게시물 ${mode == "update" ? "수정" : "삭제"}
					</td>
				</tr>

				<tr align="center">
					<td bgcolor="white" height="50">
						패스워드 &nbsp;:&nbsp;
						<input type="password" name="pwd" size="10" maxlength="10" class="boxTF">
					</td>
				</tr>
			</table>

			<table style="width: 100%; border-spacing: 0px;">
				<tr align="center" height="50">
					<td>
						<button type="submit" class="btn">확 인</button>&nbsp;
						<button type="button" name="cancel" class="btn" onclick="javascript:location.href='<%=cp%>/bbs/list?page=${page}';">취소</button>
						<input type="hidden" name="mode" value="${mode}">
						<input type="hidden" name="num" value="${num}">
						<input type="hidden" name="page" value="${page}">
					</td>
				</tr>
			</table>
		</form>

		<table style="width: 100%; margin-top: 10px; border-spacing: 0px;">
			<tr align="center" height="30">
				<td><span style='color: red'>${message}</span></td>
			</tr>
		</table>
	</div>

</body>
</html>