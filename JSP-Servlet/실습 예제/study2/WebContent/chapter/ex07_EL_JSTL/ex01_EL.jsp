<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<%--  EL : 자바를 좀 더 쉽게 사용하기 위한 표현식. 
            목적 : 출력! <%= %> 대신하는 것  --%>

<!-- + : 오로지 숫자 연산으로만 사용  -->
<p> ${3+5} </p>					
<p> ${"3"+5} </p>				
<p> ${3+null} </p>				

<!-- / : 자동으로 Double형으로 변경 -->
<p> ${10/5} </p>				
<p> ${3/2} </p>					

<!-- 삼항연산자  -->
<p> ${3>2 ? "큼":"작음"} </p>	

<!-- empty : 값이 null 이거나 비었을 경우 true 반환 --> 					
<p> ${empty"" ? "없음" : "있음"}</p>				
<p> ${empty null ? "null" : "null 아님" } </p>	

<!-- == eq ~와 같다 -->
<p> ${3==3? "같음" : "다름"}</p>					
<p> ${3 eq 3? "같음" : "다름"}</p>					

<!-- 문자열 결합 -->
<p> ${"서울" += "부산" } </p> 	

<!-- ; 두개의 식을 붙임. 앞에 있는 것은 결과가 출력되지 않음. EL 3.0부터 가능 -->
<p> ${1+2; 2+3} </p>	
<p> ${a=10} ${a} </p>
<p> ${a=10;a}</p>

<!-- 배열 표현 -->
<p> ${n=["a","b","c"]} </p>
<p> ${x=["x","y","z"]; ""} </p>
<p> ${x[1]} </p>

</body>
</html>