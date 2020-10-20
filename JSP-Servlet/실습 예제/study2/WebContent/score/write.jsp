<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");

	String msg = "";
	String error = request.getParameter("error");
	if(error!=null) {
		msg = "! 자료 입력 실패 : 중복된 학번 입니다 !";
	}
%>
<!DOCTYPE html>
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
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
}

h3 {
	margin-bottom: 15px;
	font-size: 15px;
	font-weight: bold;
}

#score_layout {	
	width: 320px;
	margin: 0px auto;
	margin-top: 50px;
}

.score_tb {
	width: 100%;
	border-collapse: collapse;
	border: 1px solid silver;
}

.first {
	width: 30%;
	height: 32px;
	text-align: center;
	border-top: 1px solid silver;
	border-bottom: 1px solid silver;
	background: #FAE0D4;
	font-size: 14px;
} 

.second {
	width: 70%;
	height: 32px;
	text-align: left;
	padding-left: 10px;
	border-top: 1px solid silver;
	border-bottom: 1px solid silver;
}

.enter {
	width: 170px;
	height: 20px;
	border-radius: 5px;
	border: 1px solid silver;
}

.button_tb {
	width: 100%;
	margin: 0px auto;
	margin-top: 10px;
	text-align: center;
}

.btn {
 	border-radius: 5px;
 	border: 1px solid silver;
 	height: 25px;
 	width: 70px;
 	cursor:pointer;
}

.btn:hover, .btn:active {
	background: #FFEAEA;
	border: 2px solid #ED9595;
}	


</style>


<script type="text/javascript">

// 생년월일 검사 
function isValidDateFormat(data) {	
	var p = /^[12][0-9]{3}[\.|\-|\/]?[0-9]{2}[\.|\-|\/]?[0-9]{2}$/;   
	if(! p.test(data)) {
		return false;
	}
	
	p = /(\.)|(\-)|(\/)/g;		
	data = data.replace(p,"");	

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

function send() {
	var f = document.scoreForm;
	
    if(! f.name.value){
        alert("이름을 입력 하세요.");
        return false;
     }
	
	if(! isValidDateFormat(f.birth.value)) {
		alert("생년월일을 입력 하세요(yyyy-mm-dd).");
		f.birth.focus();
		return;
	}
	
	if(! isValidScoreFormat(f.kor.value)) {
		alert("점수는 0~100 사이의 숫자만 가능합니다.");
		f.kor.focus();
		return;
	}
	
	if(! isValidScoreFormat(f.eng.value)) {
		alert("점수는 0~100 사이의 숫자만 가능합니다.");
		f.eng.focus();
		return;
	}
	
	if(! isValidScoreFormat(f.mat.value)) {
		alert("점수는 0~100 사이의 숫자만 가능합니다.");
		f.mat.focus();
		return;
	}
	
	f.submit();	
}
</script>
</head>

<body>

<form action="write_ok.jsp" name="scoreForm" method="post">
<div id="score_layout">
<h3>| 성적입력 </h3>
	<table class="score_tb">
		<tr>
			<td class="first">학번</td>
			<td class="second"><input class="enter" type="text" name="hak"></td>		
		</tr>
		<tr>
			<td class="first">이름</td>
			<td class="second"><input class="enter" type="text" name="name"></td>		
		</tr>
		<tr>
			<td class="first">생년월일</td>
			<td class="second"><input class="enter" type="text" name="birth"></td>		
		</tr>
		<tr>
			<td class="first">국어</td>
			<td class="second"><input class="enter" type="text" name="kor"></td>		
		</tr>
		<tr>
			<td class="first">영어</td>
			<td class="second"><input class="enter" type="text" name="eng"></td>		
		</tr>
		<tr>
			<td class="first">수학</td>
			<td class="second"><input class="enter" type="text" name="mat"></td>		
		</tr>	
	</table>
	
	<table class="button_tb">
		<tr>
			<td>
				<button class="btn" type="button" onclick="send();">등록하기</button>
				<button class="btn" type="reset">다시 입력</button>
				<button class="btn" type="button" onclick="javascript:location.href='list.jsp';">등록취소</button>
		</tr>	
		
		<tr height="30" align="center">
			<td style="color:#DF4D4D; padding-top: 10px; font-weight: bold;"><%=msg %></td>
		</tr>		
	</table>
</div>
</form>
</body>
</html>