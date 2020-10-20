<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ attribute name="trim" %>

<jsp:doBody var="content" scope="page"/>

<%
	String content = (String)jspContext.getAttribute("content");
	if(trim!=null && trim.equals("true")) {
		content = content.trim();
	}
	
	content = content.replaceAll("&", "&amp;");
	content = content.replaceAll("\"", "&quot;");
	content = content.replaceAll(">", "&gt;");
	content = content.replaceAll("<", "&lt;");
	content = content.replaceAll("\n", "<br>");
	content = content.replaceAll("\\s", "&nbsp");
%>
<%=content%>

