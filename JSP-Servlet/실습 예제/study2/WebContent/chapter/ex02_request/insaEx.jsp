<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
	font-size: 14px;
	font-family: 맑은 고딕, 돋움;
}
.btn {
	 color:#333;
 	 font-weight:500;
	 font-family: 맑은 고딕, 돋움, sans-serif;
	 border:1px solid #ccc;
	 background-color:#FFF;
	 text-align: center;
	 padding:4px 8px;
	 border-radius:4px;
	 margin-bottom: 3px;
}
.btn:active, .btn:focus, .btn:hover {
	 background-color:#e6e6e6;
	 border-color: #adadad;
	 color: #333;
}
.boxTF {
	border:1px solid #999;
	padding:4px 6px;
	border-radius:4px;
	background-color:#ffffff;
	font-family: 맑은 고딕, 돋움, sans-serif;
}
</style>

<script type="text/javascript">
function isValidKorean(data) {	// 한글만 입력하도록
	var p = /^[가-힣]+$/;	// ^ : 시작    $ : 끝   + : 하나 이상 
	return p.test(data); 	// 맞으면 true, 틀리면 false 
}

function isValidDateFormat(data) {	// yyyy-mm-dd 형식 검증 
	var p = /^[12][0-9]{3}[\.|\-|\/]?[0-9]{2}[\.|\-|\/]?[0-9]{2}$/;  // 처음에 1or2 , 그 후 0~9 중 하나가 3개 , (. - /) 허용 , ?:0-1개  
	if(! p.test(data)) {
		return false;
	}
	
	p = /(\.)|(\-)|(\/)/g;		// g: replace 쓸 경우 모든것을 검사
	data = data.replace(p,"");
	
	// 없는 날짜 검사 
	var y = parseInt(data.substr(0,4));
	var m = parseInt(data.substr(4,2));
	if(m<1 || m>12) {
		return false;
	}
	var d = parseInt(data.substr(6));
	var lastDay = (new Date(y,m,0)).getDate();
	
	if(d<1||d>lastDay) {
		return false;
	}	
	return true;
}

function sendOk() {
	var f = document.insaForm;
	
	if(! isValidKorean(f.name.value)) {	
		f.name.focus();
		return;
	}
	
	if(! isValidDateFormat(f.birth.value)) {
		f.birth.focus();
		return;
	}
	
	// 전화번호 형식 검사 
	if(!/^(010)-[0-9]{4}-[0-9]{4}$/.test(f.phone.value)) {
		f.phone.focus();
		return;
	}
	
	// 숫자 형식 확인 
	if(!/^(\d+)$/.test(f.salary.value)) {		// \d+ : 숫자 1개 이상 , \d(5,10) : 숫자 5~10자리 
		f.salary.focus();
		return;
	}
	
	if(!/^\d{0,7}$/.test(f.bonus.value)) {		// 0 : 안써도 된다는 뜻 
		f.bonus.focus();
		return;
	}
	
	f.submit();
}
</script>

</head>
<body>

<div style="width: 500px; margin:30px auto 5px;">
	<h3>| 인사관리</h3>
	
	<form name="insaForm" action="insaEx_ok.jsp" method="post">
	<table border="1" style="width: 100%; margin-top:7px; border-spacing: 0; border-collapse: collapse;">
		<tr height="35">
		   <td width="100" align="right" style="padding-right: 5px">이름</td>
		   <td width="300" style="padding-left: 10px">
		         <input type="text" name="name" class="boxTF">
		   </td>
		</tr>
		<tr height="35">
		   <td width="100" align="right" style="padding-right: 5px">생년월일</td>
		   <td width="300" style="padding-left: 10px">
		         <input type="text" name="birth" class="boxTF">
		   </td>
		</tr>
		<tr height="35">
		   <td width="100" align="right" style="padding-right: 5px">전화번호</td>
		   <td width="300" style="padding-left: 10px">
		         <input type="text" name="phone" class="boxTF">
		   </td>
		</tr>
		<tr height="35">
		   <td width="100" align="right" style="padding-right: 5px">기본급</td>
		   <td width="300" style="padding-left: 10px">
		         <input type="text" name="salary" class="boxTF">
		   </td>
		</tr>
		<tr height="35">
		   <td width="100" align="right" style="padding-right: 5px">수당</td>
		   <td width="300" style="padding-left: 10px">
		         <input type="text" name="bonus" class="boxTF">
		   </td>
		</tr>
	</table>
	
	<table style="width: 100%; margin-top:10px; border-spacing: 0;border-collapse: collapse;">
	<tr height="40" align="center">
	   <td><input type="button" value=" 등록하기 " class="btn" onclick="sendOk();"></td>
	</tr>
	</table>
	</form>
</div>

</body>
</html>