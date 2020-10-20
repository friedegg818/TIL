<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

	<form action="<%=cp %>/upload/write_ok.do" method="post" enctype="multipart/form-data">
		<p> 제목 : <input type="text" name="subject"> </p>
		<p> 파일 : <input type="file" name="selectFile"> </p>
		<p> <button> 등록 </button> </p>	
	</form>
	
</body>
</html>