<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");

	// 파라미터를 Map으로 받기 : 키 (파라미터이름), 값(파라미터값)
	Map<String, String[]> map = request.getParameterMap();	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<%	
	String name = map.get("name")[0];
	out.print("이름:"+name+"<br>");
	
	Iterator<String> it = map.keySet().iterator();
	while(it.hasNext()) {
		String key = it.next();
		String[] ss = map.get(key);
		if(ss!=null) {
			for(String s: ss) {
				out.print(key+":"+s+"<br>");
			}
		}
	}
%>

</body>
</html>