<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String hak = request.getParameter("hak");
	// String hobby = request.getParameter("hobby"); 파라미터 이름이 동일하면 하나만 넘겨 받는다. 

	// 파라미터의 이름이 동일한 경우 
	String hobby = ""; 
	String []hh = request.getParameterValues("hobby");
	if(hh!=null) {
		for(String h : hh) {
			hobby += h+" "; 
		}
	}
	
	String subject ="";
	String []ss = request.getParameterValues("subject");
	if(ss!=null) {
		for(String s : ss) {
			subject += s+" ";
		}
	}	
	
	String memo = request.getParameter("memo");
	memo = memo.replaceAll("\n","<br>");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> 아이디 : <%=id %> </p>
<p> 비밀번호 : <%=pwd %> </p>
<p> 이름 : <%=name %> </p>
<p> 성별 : <%=gender %> </p>
<p> 학력 : <%=hak %> </p>
<p> 취미 : <%=hobby %> </p>
<p> 좋아하는 과목 : <%=subject %> </p>
<p> 메모 : <%=memo %> </p>

</body>
</html>