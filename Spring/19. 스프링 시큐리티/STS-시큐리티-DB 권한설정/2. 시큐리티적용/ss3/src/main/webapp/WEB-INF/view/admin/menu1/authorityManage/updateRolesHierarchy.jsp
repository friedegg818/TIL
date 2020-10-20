<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<form id="rolesHierarchyForm" name="rolesHierarchyForm" method="post">
  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">권한(롤)</label>
	   </td>
	   <td style="padding: 0 0 15px 15px;">
	         <p style="margin-bottom: 5px;">
               <select name="parent_role" class="selectField" style="width: 95%;">
                  <c:forEach var="vo" items="${listRoles}">
                    <c:if test="${vo.authority!='ROLE_ADMIN'}">
             		     <option value="${vo.authority}" ${parent_role==vo.authority?"selected='selected'":""}>${vo.authority}(${vo.role_name})</option>
             		 </c:if>
                  </c:forEach>
               </select>
	         </p>
	   </td>			
	</tr>
			
   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">상위 권한</label>
	   </td>
	   <td style="padding: 0 0 15px 15px;">
	         <p style="margin-bottom: 5px;">
               <select name="child_role" class="selectField" style="width: 95%;">
                  <c:forEach var="vo" items="${listRoles}">
             		<option value="${vo.authority}" ${child_role==vo.authority?"selected='selected'":""}>${vo.authority}(${vo.role_name})</option>
                  </c:forEach>
               </select>
	         </p>
	   </td>			
	</tr>
  </table>
  
  <c:if test="${mode=='update'}">
		<input type="hidden" name="parent_OldRole" value="${parent_role}">  
		<input type="hidden" name="child_OldRole" value="${child_role}">  
  </c:if>
  <input type="hidden" name="mode" value="${mode}">
</form>
