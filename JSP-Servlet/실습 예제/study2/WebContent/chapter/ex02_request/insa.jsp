<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

#insatb {
	width: 450px;
	margin: 30px auto;
}

.insa {
	width: 100%;
	margin-top: 10px;
	border-spacing: 0;
	border-collapse: collapse;
}

.irow {
	height: 30px;
	border-top: 1px solid gray;
	border-bottom: 1px solid gray;
}

.first {
	width: 20%;
	font-size: 14px;
	padding: 5px;
	padding-right: 10px;
	background: #EAEAEA;
	text-align: right;
}

.second {
	width: 80%;
	padding: 5px;
	padding-left: 10px;
	text-align: left;
}

.enter {
	border: 1px solid #d2d2d2;
	border-radius: 5px;
	height: 20px;
}

.btn {
	background: white;
	height: 25px;
	border: 1px solid #d2d2d2;
	border-radius: 5px;
}

.brow {
	height: 50px;
	padding-top: 20px;
}	
</style>

<script type="text/javascript">
function send() {
	var f = document.insaForm;
	
	if(!f.sal.value || isNaN(f.sal.value)) {
		alert("숫자만 가능합니다.");
		f.sal.focus();
		return;
	}
	
	if(!f.bonus.value || isNaN(f.bonus.value)) {
		alert("숫자만 가능합니다.");
		f.bonus.focus();
		return;
	}
	
	f.submit();	
}
</script>


</head>
<body>

<div id="insatb">
	<form name="insaForm" action="insa_ok.jsp" method="post">
		<table class="insa">
			<tr class="irow">
				<td class="first">이름</td>
				<td class="second"><input class="enter" type="text" name="name"></td>
			</tr>
			<tr class="irow">
				<td class="first">생년월일</td>
				<td class="second"><input class="enter" type="text" name="birth"></td>
			</tr>
			<tr class="irow">
				<td class="first">전화번호</td>
				<td class="second"><input class="enter" type="text" name="tel"></td>
			</tr>
			<tr class="irow">
				<td class="first">기본급</td>
				<td class="second"><input class="enter" type="text" name="sal"></td>
			</tr>
			<tr class="irow">
				<td class="first">수당</td>
				<td class="second"><input class="enter" type="text" name="bonus"></td>
			</tr>
			<tr class="brow">
				<td colspan="2" style="text-align: center;"><button class="btn" type="button" onclick="send();">등록하기</button>
			</tr>
		</table>
	</form>
</div>
</body>
</html>