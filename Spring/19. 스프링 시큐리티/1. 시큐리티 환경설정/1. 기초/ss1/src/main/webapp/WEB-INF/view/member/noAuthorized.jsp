<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>spring</title>

<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">

<script type="text/javascript" src="<%=cp%>/resource/js/util.js"></script>
</head>

<body>

<div class="header">
    <jsp:include page="/WEB-INF/view/layout/header.jsp"/>
</div>
	
<div class="container">
    <div class="body-container" style="width: 700px; margin-top: 20px;">
        
	    <div style="margin: 0px auto; padding-top:90px; width:420px;">
	    	<div style="text-align: center;">
	        	<span style="font-weight: bold; font-size:27px; color: #424951;"><strong>경고 !</strong></span>
	        </div>
	        
	        <div class="messageBox">
	            <div style="line-height: 150%; padding-top: 35px;">
	                    해당 정보를 접근 할 수 있는 권한 이 없습니다.
	            </div>
	            <div style="margin-top: 20px;">
	                     <button type="button" onclick="javascript:location.href='<%=cp%>/';" class="btnConfirm">메인화면으로 이동</button>
	                </div>
	        </div>
	     </div>
	      
     </div>    
</div>

<div class="footer">
    <jsp:include page="/WEB-INF/view/layout/footer.jsp"/>
</div>

</body>
</html>

