<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	String s = String.format("%1$tF %1$tA %1$tT",Calendar.getInstance());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3 style="width:100px; background:#A566FF; color: white;">˓˓ฅ₍˄ุ.͡ ̫.˄ุ₎ฅ˒˒</h3>

<p>
	최근 접속 시간 : <b style="font-style: italic; color:#A566FF"><%=s %></b> 
</p>
</body>
</html>