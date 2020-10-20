<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ attribute name="subject" required="true" %>
<%@ attribute name="score" required="true" type="Integer" %>

<%
	double d = 0.0;
	if(score>=95) d=4.5;
	else if(score>=90) d=4.0;
	else if(score>=85) d=3.5;
	else if(score>=80) d=3.0;
	else if(score>=75) d=2.5;
	else if(score>=70) d=2.0;
	else if(score>=65) d=1.5; 
	else d=0.0;
%>
${subject} : <%=d %>
