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

<form action="ex1_ok.jsp" method="post">
	<p> 아이디 : <input type="text" name="id"> </p>
	<p> 패스워드 : <input type="password" name="pwd"> </p>
	<p> 이름 : <input type="text" name="name"> </p>
	<p> 성별 : 
			<input type="radio" name="gender" value="남" checked="checked"> 남자
		    <input type="radio" name="gender" value="여"> 여자 	
		    <!-- radio 나 checkbox 는 반드시 value 값을 주어야 서버로 넘어 갈 수 있음 -->
    </p>
	<p> 학력 : 
		<select name="hak">
			<option value="">::선택::</option>
			<option value="대졸" selected="selected">대졸</option>
			<option value="고졸">고졸</option>
			<option value="기타">기타</option>
		</select>
	</p>
	<p> 
		<input type="checkbox" name="hobby" value="운동"> 근육맨만들기  
		<input type="checkbox" name="hobby" value="게임"> 누워서 게임하기  
		<input type="checkbox" name="hobby" value="영화"> 영화 보기   
		<input type="checkbox" name="hobby" value="독서"> 설마 책보는 사람  
		<input type="checkbox" name="hobby" value="음악"> 귀 아프겠다..  	  
		<input type="checkbox" name="hobby" value="여행"> 집에 있기 싫다!
	</p>
	<p> 좋아하는 과목 :		
		<select name="subject" multiple="multiple" size="5">
			<option value="java">자바</option>
			<option value="spring">스프링</option>
			<option value="oracle">오라클</option>
			<option value="html">HTML</option>
			<option value="css">CSS</option>		
		</select>
	</p>
	<p> 메모 : 
		<textarea rows="5" cols="60" name="memo">내일부터 휴일</textarea>
	</p>	
	<p>
		<button type="submit">보내기</button>
		<button type="reset">다시 입력</button>		<!-- 반드시 form 태그 안에 있어야 작동 -->
</form>

</body>
</html>