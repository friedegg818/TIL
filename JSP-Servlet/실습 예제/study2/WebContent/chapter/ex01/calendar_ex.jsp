<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("UTF-8");

	Calendar cal = Calendar.getInstance();
	
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH)+1;
	
	String sy = request.getParameter("year");
	String sm = request.getParameter("month");
	
	if(sy!=null) {
		year = Integer.parseInt(sy);
	}
	if(sm!=null) {
		month = Integer.parseInt(sm);
	}
	
	cal.set(year, month-1, 1);
	year = cal.get(Calendar.YEAR);
	month = cal.get(Calendar.MONTH)+1;
	
	int week = cal.get(Calendar.DAY_OF_WEEK); // 1~7
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">
*{
	margin: 0; padding: 0;
}
body {
	font-size: 14px; font-family: 맑은 고딕, 돋움;
}

a {
	color: #000; text-decoration: none;
}
a:hover, a:active {
	color: tomato; text-decoration: underline;
}

#layout{
	margin: 30px auto; width: 700px;
}

#layout table {
	width: 100%; border-spacing: 0; border-collapse: collapse;
}

.calendar tr.title{
	height: 30px; text-align: center;
	background: #e4e6e4;
}
.calendar tr.date{
	height: 30px; text-align: right;
}
.calendar tr.schedule{
	height: 100px; text-align: left;
}

.calendar td{
	width: 100px;
	color: black;
	box-sizing: border-box;
}
.calendar tr.date td{
	padding-right: 5px;
}
.calendar tr.schedule td{
	padding: 5px;
	vertical-align: top;
}

.calendar  tr.date td:nth-child(7n+1){
	color: red;
}
.calendar  tr.date td:nth-child(7n){
	color: blue;
}
.calendar  tr.date td.gray{
	color: gray;
}
</style>

<script type="text/javascript">
function change() {
	var f = document.calendarForm;
	f.action="calendar_ex.jsp";
	f.submit();
}
</script>

</head>
<body>

<div id="layout">
<form name="calendarForm" method="post">
	<table>
		<tr align="center" height="30">
			<td>
					<select name="year" onchange="change();">
						<% for(int i=year-5; i<=year+5; i++) { %>
								<option value="<%=i%>"  <%=year == i ? "selected='selected' ":"" %> ><%=i%>년</option>
						 <% } %>
					</select>
					
					<select name="month" onchange="change();">
						<% for(int i=1; i<=12; i++) { %>
								<option value="<%=i%>"  <%=month == i ? "selected='selected' ":"" %> ><%=i%>월</option>
						 <% } %>
					</select>
					
			</td>
		</tr>
	</table>
</form>
	
	<table border="1" class="calendar">
		<tr class="title">
			<td>일</td>
			<td>월</td>
			<td>화</td>
			<td>수</td>
			<td>목</td>
			<td>금</td>
			<td>토</td>
		</tr>
		
<%
		out.print("<tr class='date'>");
		
		Calendar preCal = (Calendar)cal.clone();
		preCal.set(Calendar.DATE, -(week-1-1));
		int preDate = preCal.get(Calendar.DATE);
		
		// 1일 앞 처리
		for(int i=1; i<week; i++) {
			out.print("<td class='gray'>"+(preDate++)+"</td>");
		}
		
		// 1~말일까지 출력하기
		int lastDay = cal.getActualMaximum(Calendar.DATE);
		for(int i=1; i<=lastDay; i++) {
			out.print("<td>"+i+"</td>");
			week++;
			if(week%7==1&&i!=lastDay) {
				out.print("</tr>");
				out.print("<tr class='schedule'>");
				for(int n=i-6; n<=i; n++) {
					out.print("<td>");
					// out.print("&nbsp;");
					out.print(n+"일 일정..");
					out.print("</td>");
				}
				out.print("</tr>");
				out.print("<tr class='date'>");
			}
		}
		
		// 마지막 주 마지막 일자 다음 처리
		int n=1;
		if(week%7!=1 && week%7!=0) { // 마지막일자가 일~목 인 경우
			for(int i=week%7; i<=7; i++) {
				out.print("<td class='gray'>"+(n++)+"</td>");
			}
		} else if(week%7==0) { // 마지막일자가 금요일인 경우
			out.print("<td class='gray'>"+(n)+"</td>");
		}
		out.print("</tr>");
		
		n=week%7-1;
		if(week%7==0) n=6;
		if(week%7==1) n=7;
		out.print("<tr class='schedule'>");
		for(int i=lastDay-n+1; i<=lastDay-n+7; i++) {
			out.print("<td>");
			out.print(i+"일 일정..");
			out.print("</td>");
		}
		out.print("</tr>");
%>
	</table>
	
</div>

</body>
</html>