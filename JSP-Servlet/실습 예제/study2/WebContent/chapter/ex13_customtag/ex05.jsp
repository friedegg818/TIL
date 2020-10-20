<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags" %>
<%

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<div>
	<tf:htmlSymbols>
	   	안녕 
		반가워요 	
		 <hr> : 선을 그립니다.	
	</tf:htmlSymbols>
</div>
<hr>
<div>
	<tf:htmlSymbols>
	  <jsp:body>
	   	안녕 
		반가워요 	
		 <hr> : 선을 그립니다.
	  </jsp:body>
	</tf:htmlSymbols>
</div>
<hr>
<div>
	<tf:htmlSymbols2>
	  <jsp:body>
	   	안녕 
		반가워요 	
		 <hr> : 선을 그립니다.
	  </jsp:body>
	</tf:htmlSymbols2>
</div>

</body>
</html>