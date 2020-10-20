<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type,
		url:url,
		data:query,
		dataType:"json",
		success:function(data) {
			fn(data);
		},
		error:function(e){
			console.log(e.responseText);
		}
	});
}

$(function(){
	$("#btnSend").click(function(){
		var url="<%=cp%>/weather/search";
		var query={temp:new Date().getTime()};
		var fn = function(data){
			 console.log(data);
			
			var out="";
			var list=data.response.body.items.item;
			var category;
			var obsrValue;
			$.each(list, function(index, item){
				// 초단기 실황
				category=item.category;
				obsrValue=item.obsrValue;
				
				if(category=="PTY") { // 강수형태-0:없음,1:비,2:눈/비,3:눈,4:소나기 
				} else if(category=="REH") { // 습도
				} else if(category=="RN1") { // 강수량-0:없음,1:1mm이하,5:1~4mm,10:5~9mm,20:10~19mm,40:20~39mm,70:40~69mm,100:100mm이상
				} else if(category=="T1H") { // 섭씨온도
					out+="섭씨온도:"+obsrValue;
				} else if(category=="UUU") { // 동서바람성분
				} else if(category=="VEC") { // 풍향
				} else if(category=="VVV") { // 남북바람성분
				} else if(category=="WSD") { // 풍속
				}
			});
			
			$("#resultLayout").html(out);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

$(function(){
	$("#btnSend2").click(function(){
		// 초단기 예보
		var url="<%=cp%>/weather/search2";
		var base_date="20200615";
		var base_time="1130";
		var nx="59";
		var ny="126";
		var query="base_date="+base_date+"&base_time="+base_time+"&nx="+ny+"&ny="+ny;
		
		var out="";
		var fn=function(data) {
			// console.log(data);
			var category;
			var fcstDate, fcstTime; // 발표일자, 시간
			var fcstValue;
			
			if(! data.response.body) {
				alert("등록된 정보가 없습니다.");
				return false;
			}
			
			var list=data.response.body.items.item;

			category=list[0].category; // LGT : 나뢰
			fcstDate=list[0].fcstDate;
			fcstTime=list[0].fcstTime;
			fcstValue=list[0].fcstValue;
			out+="발표일자:"+fcstDate+"<br>";
			out+="발표시간:"+fcstTime+"<br>";
			
			category=list[4].category; // PTY : 강수형태
			fcstDate=list[4].fcstDate;
			fcstTime=list[4].fcstTime;
			fcstValue=list[4].fcstValue;

			category=list[8].category; // RN1 : 1시간 강수량
			fcstDate=list[8].fcstDate;
			fcstTime=list[8].fcstTime;
			fcstValue=list[8].fcstValue;

			category=list[12].category; // SKY : 하늘상태
			fcstDate=list[12].fcstDate;
			fcstTime=list[12].fcstTime;
			fcstValue=list[12].fcstValue;
			if(fcstValue=="1") {
				out+="하늘상태 : 맑음<br>";
			} else if(fcstValue=="3") {
				out+="하늘상태 : 구름 많음<br>";
			} else if(fcstValue=="4") {
				out+="하늘상태 : 흐림<br>";
			}
			
			category=list[16].category; // T1H : 섭씨 기온
			fcstDate=list[16].fcstDate;
			fcstTime=list[16].fcstTime;
			fcstValue=list[16].fcstValue;
			out+="섭씨온도:"+fcstValue+"<br>";
			
			$("#resultLayout").html(out);
		};
		
		ajaxJSON(url, "post", query, fn);
		
	});
});

</script>


</head>
<body>

<div>
	<h3>동네예보</h3>
	<div>
		<p> <button type="button" id="btnSend">초단기 실황 확인</button> </p>
	</div>
	<hr>
	
	<div>
		<p> <button type="button" id="btnSend2">초단기  예보 확인</button> </p>
	</div>
	<hr>
	
	<div id="resultLayout"></div>
</div>

</body>
</html>