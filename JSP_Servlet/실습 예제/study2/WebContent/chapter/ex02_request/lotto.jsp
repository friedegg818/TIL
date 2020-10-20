<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">

#paper {
	margin: 30px auto;
	width: 450px;
}

h3 {
	font-size: 14px;
	text-align: center;	
	padding-bottom: 5px;
	border-bottom: 1px solid silver;
}

.cnt {	
	font-size: 13px;	
	border-bottom: 1px solid silver;
	height: 30px;
	line-height: 30px;
}

.enter {
	width: 50px;
	height: 15px;
	margin: 3px;
	/* border-radius: 4px; */
}

.choice {
	text-align: right;
}

.bnt {
	margin-top : 5px;
	text-align: center;
}
</style>

<script type="text/javascript">
function buy() {
	var f = document.lottoForm;
	
	// 로또 장수 제한
	if(!/^[1-5]{1}$/.test(f.count.value)) {
		alert("로또는 1-5장만 구입 가능합니다.")	
		f.count.focus();
		return;
	}	
	
	// 로또 번호 선택하기 
	var cnt = 0;
	for(var i=0; i<f.select.length; i++) {
		if(f.select[i].checked) cnt++;
	}
	
	if(cnt<1 || cnt>6) {
		alert("로또 번호는 1-6개를 선택하세요.")
		return;
	}	
	
	alert("성공");
}

</script>

</head>
<body>

<div id="paper">
<form name="lottoForm" action="lotto_ok.jsp" method="post">
	<h3>꿈의 로또</h3>
	<p class="cnt">* 로또 구매 갯수[1~5] : 
		<input class="enter" type="text" name="count">
	</p>
	<p class="cnt">* 포함 할 수 [최대 6개까지 추가 가능] </p>
	<div style="border-bottom: 1px solid silver; padding-bottom: 5px;">
		<div class="choice">
		<%
			for(int i=1; i<=45; i++) {			
				out.print(i+"<input type='checkbox' name='select' value="+i+">");			
			
				if(i%9==0) {
					out.print("<br>");
				}
				
			}
		%>	
		</div>
	</div>
</form>	
	<button class="bnt" type="button" onclick="buy();">구매하기</button>
	



</div>


</body>
</html>