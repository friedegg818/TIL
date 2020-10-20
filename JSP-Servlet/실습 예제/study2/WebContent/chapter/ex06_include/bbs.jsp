<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">
* { padding:0; margin:0; }

body {
	font-family: 맑은 고딕, 돋움;
}

a {
	cursor: pointer; text-decoration: none;
}

a:hover, a:active {
	color: tomato; text-decoration: underline;
}

#main-layout {
	width: 800px;
	margin: 20px auto 5px;
}

#header {
	height: 35px; line-height: 35px; text-align: center; border:1px solid #ccc;
}

#header li {
	float: left; list-style: none; margin: 0; padding: 0;
	padding-left: 20px; padding-right: 20px;
}

.menuItem {
	display: inline-block; color: #333; text-decoration: none;
}

.menuItem:hover, .menuItem:active {
	color: #333; text-decoration: none; font-weight: 700;
}

#body-content {
	clear: both;
	min-height: 500px;
	padding: 5px;
}

#footer {
	height: 35px; line-height: 35px; text-align: center; 
}

</style>


</head>
<body>

<div id="main-layout">
	<div id="header">
		<jsp:include page="header.jsp"/>
	</div>
	<div id="body-content">
		<h3> 게시판 </h3>
		<p> 비방하면 혼난당 </p>
	</div>
	<div id="footer">
		<jsp:include page="footer.jsp"/>
	</div>
</div>


</body>
</html>