<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="p" uri="/WEB-INF/paginate.tld" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String pageNum = request.getParameter("page");
	int current_page = 1; 
	if(pageNum!=null) {
		current_page = Integer.parseInt(pageNum);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<div style="text-align: center;">
	<p:page total_page="1258" uri="ex02.jsp" current_page="<%=current_page%>"/>
</div>


</body>
</html>