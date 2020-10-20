<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<table style='width: 100%; margin: 15px auto 10px; table-layout:fixed; word-break:break-all; border-spacing: 0px; '>

<c:forEach var="dto" items="${list}">
<tr height='35' bgcolor='#eeeeee'>
    <td width='50%' style='padding-left: 5px; border:1px solid #cccccc; border-right:none;'>
        <span style='font-weight: 600;'>${dto.name}</span>
    </td>
    <td width='50%' align='right' style='padding-right: 5px; border:1px solid #cccccc; border-left:none;'>
        ${dto.created} |
		<a onclick='deleteGuest("${dto.num}", "${pageNo}");'>삭제</a>
    </td>
</tr>
<tr height='50'>
    <td colspan='2' style='padding: 5px;' valign='top'>
       ${dto.content}
    </td>
</tr>
</c:forEach>


<tr height='40'>
    <td colspan='2' align='center'>
     ${dataCount==0 ? "등록된 자료가 없습니다." : paging}
    </td>
</tr>    

</table>
