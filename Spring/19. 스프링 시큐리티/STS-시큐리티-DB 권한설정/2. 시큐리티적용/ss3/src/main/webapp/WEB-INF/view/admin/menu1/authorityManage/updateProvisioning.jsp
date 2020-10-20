<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<form id="provisioningForm" name="provisioningForm" method="post">
  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">리소스 명</label>
	   </td>
	   <td style="padding: 0 0 15px 15px;">
	         <p style="margin-bottom: 5px;">
	             <select name="resource_id" class="selectField" onchange="selectPattern();" style="width: 95%;">
	                <c:forEach var="vo" items="${listResources}">
           		        <option value="${vo.resource_id}" ${dto.resource_id==vo.resource_id?"selected='selected'":""}>${vo.resource_name}</option>
           		    </c:forEach>
               </select>
	         </p>
	   </td>			
	</tr>
			
   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">리소스 패턴</label>
	   </td>
	   <td style="padding: 0 0 15px 15px;">
	         <p style="margin-bottom: 5px;">
	             <select name="resource_id2" class="selectField" disabled="disabled" style="width: 95%;">
	                <c:forEach var="vo" items="${listResources}">
           		        <option value="${vo.resource_id}" ${dto.resource_id==vo.resource_id?"selected='selected'":""}>${vo.resource_pattern}</option>
           		    </c:forEach>
               </select>
	         </p>
	   </td>
	</tr>

   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">권한</label>
	   </td>
	   <td style="padding: 0 0 15px 15px;">
	         <p style="margin-bottom: 5px;">
	             <select name="authority" class="selectField" style="width: 95%;">
	                 <c:forEach var="vo" items="${listRoles}">
           		         <option value="${vo.authority}" ${dto.authority==vo.authority?"selected='selected'":""}>${vo.authority}</option>
           		     </c:forEach>
               </select>
	         </p>
	   </td>			
	</tr>

  <c:if test="${mode=='update'}">
   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">등록일</label>
	   </td>
	   <td style="padding: 5px 0 15px 15px;">
             <label>${dto.created_date}</label>
	   </td>
   </tr>			
   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">수정일</label>
	   </td>
	   <td style="padding: 5px 0 15px 15px;">
             <label>${dto.modify_date}</label>
	   </td>
   </tr>			
  </c:if>	
  </table>
  
  <c:if test="${mode=='update'}">
		<input type="hidden" name="oldResource_id" value="${dto.resource_id}">
		<input type="hidden" name="oldAuthority" value="${dto.authority}">
  </c:if>
  <input type="hidden" name="mode" value="${mode}">
</form>
