<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	int score = Integer.parseInt(request.getParameter("score"));
	
	String str = (String)request.getAttribute("s");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> 포워딩 된 페이지 </h3>

<p> 이름 : <%=name %> </p>
<p> 점수 : <%=score %> </p>
<p> 결과 : <%=str %> </p>


<p> 
 포워딩은 서버 내에서 이루어지므로 클라이언트는 알 수 없다. <br>
 즉, 주소가 변경되지 않는다. <br>
 포워딩한 경우 request, response 객체가 그대로 넘어오기 때문에 파라미터를 그대로 받을 수 있다. <br>
 서블릿이나 JSP에서 포워딩한 페이지에 다른 값을 넘겨야 하는 경우 request.setAttribute()와 request.getAttribute() 메소드를 이용한다.

</body>
</html>