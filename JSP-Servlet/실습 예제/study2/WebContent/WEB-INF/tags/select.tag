<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ tag dynamic-attributes="optionMap" %>
<%@ attribute name="name" required="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<select name="${name}">
	<c:forEach var="s" items="${optionMap}">
		<option value="${s.key}">${s.value}</option>
	</c:forEach>
</select>

