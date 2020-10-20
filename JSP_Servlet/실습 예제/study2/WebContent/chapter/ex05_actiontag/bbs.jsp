<%@page import="com.util.MyUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	MyUtil myUtil = new MyUtil();
	
	String pageNum = request.getParameter("page");
	int current_page = 1;
	if(pageNum!=null) {
		current_page = Integer.parseInt(pageNum);
	}
	
	int dataCount = 1078;
	int rows = 10;
	int total_page = myUtil.pageCount(rows, dataCount);
	
	String listUrl = "bbs.jsp";
//	String listUrl = "bbs.jsp?condition=subject&keyword=java";

	String paging = myUtil.paging(current_page, total_page, listUrl);	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
*{
	padding: 0; margin: 0;
}

body {
	font-size: 14px; font-family: 맑은 고딕, 돋움;
}

a {
	text-decoration: none;
	color: #000;
}

a:hover, a:active {
	text-decoration: underline;
	color: tomato;
}
</style>
</head>
<body>

<div style="margin: 30px auto; width: 700px;">
<h3>게시판</h3>

	<table style="width:100%; margin-top: 10px;">
		<tr height="30">
			<td>
				총 페이지 수 : <%=total_page %>, 현재 페이지 : <%=current_page %>
			</td>
		</tr>
	
		<tr height="30" align="center">
			<td>
				<%=paging %>
			</td>
		</tr>
	</table>

</div>

</body>
</html>