<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
*{
    margin:0; padding: 0;
}
body {
    font-size:14px;
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
}
a{
    color:#000000;
    text-decoration:none;
    cursor:pointer;
}
a:active, a:hover {
    text-decoration: underline;
    color:tomato;
}
textarea:focus, input:focus{
    outline: none;
}
.btn {
    color:#333333;
    font-weight:500;
    font-family:"맑은 고딕", 나눔고딕, 돋움, sans-serif;
    border:1px solid #cccccc;
    background-color:#ffffff;
    text-align:center;
    cursor:pointer;
    padding:3px 10px 5px;
    border-radius:4px;
}
.btn:active, .btn:focus, .btn:hover {
    background-color:#e6e6e6;
    border-color:#adadad;
    color:#333333;
}
.boxTF {
    border:1px solid #999999;
    padding:3px 5px 5px;
    border-radius:4px;
    background-color:#ffffff;
    font-family:"맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
.selectField {
    border:1px solid #999999;
    padding:2px 5px 4px;
    border-radius:4px;
    font-family:"맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
.title {
    font-weight:bold;
    font-size:16px;
    font-family:나눔고딕, "맑은 고딕", 돋움, sans-serif;
}
</style>
<script type="text/javascript">
if(typeof String.prototype.trim !== 'function') {	// 공백을 제거하는 함수 추가 
    String.prototype.trim = function() {
        var TRIM_PATTERN = /(^\s*)|(\s*$)/g;
        return this.replace(TRIM_PATTERN, "");
    };
}

function isValidDateFormat(data){
    var regexp = /[12][0-9]{3}[\.|\-|\/]?[0-9]{2}[\.|\-|\/]?[0-9]{2}/;
    if(! regexp.test(data))
        return false;

    regexp=/(\.)|(\-)|(\/)/g;
    data=data.replace(regexp, "");
    
	var y=parseInt(data.substr(0, 4));
    var m=parseInt(data.substr(4, 2));
    if(m<1||m>12) 
    	return false;
    var d=parseInt(data.substr(6));
    var lastDay = (new Date(y, m, 0)).getDate();
    if(d<1||d>lastDay)
    	return false;
		
	return true;
}

function isValidScoreFormat(data){
	var regexp = /^(\d+)$/;
	if(! regexp.test(data)) {
        return false;
	}
	
	if(parseInt(data)<0 || parseInt(data)>100) {
        return false;
	}
	
	return true;
}

function check() {
	var f=document.forms[0];
	var format, s;
	
	format=/^\d{4,10}$/;
	if(! format.test(f.hak.value)) {
		alert("학번은 4~10이내의 숫자만 가능 합니다.");
		f.hak.focus();
		return false;
	}
	
	s=f.name.value;
	s=s.trim();
	if(! s) {
		alert("이름을 입력 하세요.");
		f.name.focus();
		return false;
	}
	f.name.value=s;

	if(! isValidDateFormat(f.birth.value)) {
		alert("생년월일을 입력 하세요(yyyy-mm-dd).");
		f.birth.focus();
		return false;
	}
	
	if(! isValidScoreFormat(f.kor.value)) {
		alert("점수는 0~100 사이의 숫자만 가능합니다.");
		f.kor.focus();
		return false;
	}

	if(! isValidScoreFormat(f.eng.value)) {
		alert("점수는 0~100 사이의 숫자만 가능합니다.");
		f.eng.focus();
		return false;
	}

	if(! isValidScoreFormat(f.mat.value)) {
		alert("점수는 0~100 사이의 숫자만 가능합니다.");
		f.mat.focus();
		return false;
	}
	
	return true;
}
</script>
</head>
<body>

<div style="width: 500px; margin: 30px auto;">
	<table style="width: 100%; border-spacing: 0; border-collapse: collapse;">
	<tr height="40">
	   <td align="left" class="title">
			| 성적처리
		</td>
	</tr>
	</table>
	
	<form action="write_ok.jsp" method="post" onsubmit="return check();">
	<table style="width: 100%; margin-top: 10px; border-spacing: 0; border-collapse: collapse;">
	<tr height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" align="center">학번</td>
		<td style="padding-left: 10px;">
			<input type="text" name="hak" class="boxTF" size="30" maxlength="10">
		</td>
	</tr>
	
	<tr height="40" style="border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" align="center">이름</td>
		<td style="padding-left: 10px;">
			<input type="text" name="name" class="boxTF" size="30" maxlength="10">
		</td>
	</tr>
	
	<tr height="40" style="border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" align="center">생년월일</td>
		<td style="padding-left: 10px;">
			<input type="text" name="birth" class="boxTF" size="30" maxlength="10">
		</td>
	</tr>
	
	<tr height="40" style="border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" align="center">국어</td>
		<td style="padding-left: 10px;">
			<input type="text" name="kor" class="boxTF" size="30" maxlength="3">
		</td>
	</tr>
	
	<tr height="40" style="border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" align="center">영어</td>
		<td style="padding-left: 10px;">
			<input type="text" name="eng" class="boxTF" size="30" maxlength="3">
		</td>
	</tr>
	
	<tr height="40" style="border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" align="center">수학</td>
		<td style="padding-left: 10px;">
			<input type="text" name="mat" class="boxTF" size="30" maxlength="3">
		</td>
	<tr height="45">
		<td align="center" colspan="2">
			<input type="submit" value=" 등록완료 " class="btn">	
			<input type="reset" value=" 다시입력 " class="btn">	
			<input type="button" value=" 등록취소 " class="btn" onclick="javascript:location.href='list.jsp';">	
		</td>
	</tr>
	</table>
	</form>
</div>

</body>
</html>