<%@page import="java.text.DecimalFormat"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String tel = request.getParameter("tel");
	int sal =  Integer.parseInt(request.getParameter("sal"));
	int bonus =  Integer.parseInt(request.getParameter("bonus"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

#insatb {
	width: 450px;
	margin: 30px auto;
}

.insa {
	width: 100%;
	margin-top: 10px;
	border-spacing: 0;
	border-collapse: collapse;
}

.irow {
	height: 30px;
	border-top: 1px solid gray;
	border-bottom: 1px solid gray;
}

.first {
	width: 20%;
	font-size: 14px;
	padding: 5px;
	padding-right: 10px;
	background: #EAEAEA;
	text-align: right;
}

.second {
	width: 80%;
	padding: 5px;
	padding-left: 10px;
	text-align: left;
}

.enter {
	border: 1px solid #d2d2d2;
	border-radius: 5px;
	height: 20px;
}

.btn {
	background: white;
	height: 25px;
	border: 1px solid #d2d2d2;
	border-radius: 5px;
}

.brow {
	height: 50px;
	padding-top: 20px;
}	
</style>

</head>
<body>
<div id="insatb">
	<table class="insa">
			<tr class="irow">
				<td class="first">이름</td>
				<td class="second"><%=name %></td>
			</tr>
			<tr class="irow">
				<td class="first">생년월일</td>
				<td class="second"><%=birth %></td>
			</tr>
			<tr class="irow">
				<td class="first">띠</td>
				<td class="second"></td>
			</tr>
			<tr class="irow">
				<td class="first">나이</td>
				<td class="second"></td>
			</tr>
			<tr class="irow">
				<td class="first">전화번호</td>
				<td class="second"><%=tel %></td>
			</tr>
			<tr class="irow">
				<td class="first">기본급</td>
				<td class="second">\<%=sal %></td>
			</tr>
			<tr class="irow">
				<td class="first">수당</td>
				<td class="second">\<%=bonus %></td>
			</tr>
			<tr class="irow">
				<td class="first">세금</td>
				<td class="second">
					<% double tax;
					 	if((sal+bonus)>=3000000) {
					 		tax = (sal+bonus)*0.03;
					 	} else if((sal+bonus)>=2000000) {
					 		tax = (sal+bonus)*0.02; 
					 	} else {
					 		tax = 0;
					 	}					
					%>
					<%=tax %>			
				</td>
			</tr>	
			<tr class="irow">
				<td class="first">실급여</td>
				<td class="second">					
				
				</td>
			</tr>			
		</table>
</div>


</body>
</html>