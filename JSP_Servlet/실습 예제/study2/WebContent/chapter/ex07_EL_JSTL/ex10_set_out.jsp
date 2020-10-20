<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> set : request.setAttribute()의 역할을 하는 태그. 값을 저장 할 때 사용   </p>

<c:set var="result" value="1"/>
<c:forEach var="a" begin="1" end="10">
	<c:set var="result" value="${result * 2}"/>
	2 * ${a} 승 = ${result} <br>
</c:forEach>
<hr>

<p> out : 출력시 태그 자체가 보임 <br>
          escapeXml = "true" > 태그 자체가 보임 <br>
          escapeXml = "false" > 태그가 적용되어서 보임 <br>
</p> 
          
<c:out value="<p>jstl을 이용한 출력 입니다.</p>"/>
<br>
<c:out value="<p>jstl을 이용한 <b>출력</b>입니다.</p>" escapeXml="true"/>
<br>
<c:out value="<p>jstl을 이용한 <b>출력</b>입니다.</p>" escapeXml="false"/>

</body>
</html>