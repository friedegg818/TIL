<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
 
 <p> 제목 : ${subject} </p>
 <p> 서버에 저장된 파일명 : ${saveFilename} </p>
 <p> 클라이언트가 올린 파일명 : ${originalFilename} </p> 
 
</body>
</html>