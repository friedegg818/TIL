<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
     <tr height="35">
        <td align="left" width="50%">
          ${dataCount}개(${pageNo}/${total_page} 페이지)
        </td>
        <td align="right">
          <button type="button" class="btn" onclick="insertProvisioning();">등록</button>
        </td>
     </tr>
  </table>
			
  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
	  <tr><td height="1" colspan="5" bgcolor="#cccccc"></td></tr>
	  <tr align="center" bgcolor="#eeeeee" height="35"> 
	      <th style="width: 60px; color: #787878;">번호</th>
	      <th align="left" style="padding-left: 5px; width: 220px; color: #787878;">리소스명</th>
	      <th align="left" style="padding-left: 5px; color: #787878;">리소스 패턴</th>
	      <th align="left" style="padding-left: 5px; width: 220px; color: #787878;">권한</th>
	      <th style="width: 90px; color: #787878;">등록일</th>
	  </tr>
	  <tr><td height="1" colspan="5" bgcolor="#cccccc"></td></tr>
	 
	 <c:forEach var="dto" items="${list}">
	  <tr align="center" bgcolor="#ffffff" height="35" class="hover-tr"
	        onclick="updateProvisioning('${dto.resource_id}', '${dto.authority}');"> 
	      <td align="center">${dto.listNum}</td>
	      <td align="left" style="padding-left: 5px;">${dto.resource_name}</td>
	      <td align="left" style="padding-left: 5px;">${dto.resource_pattern}</td>
	      <td align="left" style="padding-left: 5px;">${dto.authority}</td>
	      <td align="center">${dto.created_date}</td>
	  </tr>
	  <tr><td height="1" colspan="5" bgcolor="#cccccc"></td></tr> 
	</c:forEach> 
	</table>
			 
	<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
	   <tr height="40">
		<td align="center">
	        <c:if test="${dataCount==0 }">
	                등록된 자료가 없습니다.
	         </c:if>
	        <c:if test="${dataCount!=0 }">
	               ${paging}
	         </c:if>
		</td>
	   </tr>
   </table>
