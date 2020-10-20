<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<c:set var="str" value="seoul korea"/>

${fn:contains(str, "kor") ? "kor 존재" : "없음" } <br>
${fn:containsIgnoreCase(str, "SEOUL") ? "seoul 존재" : "없음" } <br>

${fn:startsWith(str, "seoul") ? "seoul 로 시작" : "시작 안 함" } <br>
${fn:endsWith(str, "korea") ? "korea 로 종료" : "종료 안 함" } <br>
${fn:indexOf(str, "kor")} <br>
${fn:substring(str, 6, 9)} <br>
${fn:substringAfter(str, "seoul")} <br>
${fn:length(str)} <br>
${fn:replace(str,"korea","한국")} <br>
 

</body>
</html>