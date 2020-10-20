<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<root>
	<c:forEach var="dto" items="${list}">
	 	<record num="${dto.num}">
	 		<name>${dto.name}</name>
	 		<content><![CDATA[${dto.content}]]></content>
	 		<created>${dto.created}</created>
	 	</record>
	</c:forEach>
	<dataCount>${dataCount}</dataCount>
	<pageNo>${pageNo}</pageNo>
	<paging><![CDATA[${paging}]]></paging>
</root>