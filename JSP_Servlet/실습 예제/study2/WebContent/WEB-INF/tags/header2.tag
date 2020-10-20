<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ attribute name="title" fragment="true" %>


<!-- fragment가 true로 설정된 경우 jsp:attribute로 속성을 설정해야 함 --> 
<!-- jsp:invoke 액션태그 > jsp:attribute 몸체의 내용을 그대로 출력하도록 처리 --> 

<h3>
	<jsp:invoke fragment="title"/>
</h3>

