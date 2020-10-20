<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<form id="rolesForm" name="rolesForm" method="post">
  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">권한</label>
	   </td>
	   <td style="padding: 0 0 15px 15px;">
	         <p style="margin-bottom: 5px;">
	              <input type="text" name="authority" maxlength="100" class="boxTF" style="width: 98%;" value="${empty dto.authority?'ROLE_':dto.authority}">
	         </p>
	         <p class="help-block">
	              권한(롤)은 반드시 <span style="font-weight: 900;">ROLE_</span> 로 시작해야 합니다.
	         </p>
	   </td>			
	</tr>
			
   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">권한명</label>
	   </td>
	   <td style="padding: 0 0 15px 15px;">
	         <p style="margin-bottom: 5px;">
	             <input type="text" name="role_name" maxlength="100" class="boxTF" style="width: 98%;" value="${dto.role_name}">
	         </p>
	   </td>			
	</tr>
				
   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">권한설명</label>
	   </td>
	   <td style="padding: 0 0 15px 15px;">
             <textarea name="description" class="boxTA" style="width: 98%; height: 50px;">${dto.description}</textarea>
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
		<input type="hidden" name="oldAuthority" value="${dto.authority}">  
  </c:if>
  <input type="hidden" name="mode" value="${mode}">
</form>
