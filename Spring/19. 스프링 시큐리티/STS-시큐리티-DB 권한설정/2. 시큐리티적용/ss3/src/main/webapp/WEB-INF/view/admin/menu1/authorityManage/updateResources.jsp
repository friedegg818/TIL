<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<form id="resourcesForm" name="resourcesForm" method="post">
  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">리소스 명</label>
	   </td>
	   <td style="padding: 0 0 15px 15px;">
	         <p style="margin-bottom: 5px;">
	              <input type="text" name="resource_name" maxlength="100" class="boxTF" style="width: 98%;" value="${dto.resource_name}">
	         </p>
	         <p class="help-block">
	              리소스명은 패턴에 대한 이름입니다.
	         </p>
	   </td>			
	</tr>
			
   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">리소스 패턴</label>
	   </td>
	   <td style="padding: 0 0 15px 15px;">
	         <p style="margin-bottom: 5px;">
	             <input type="text" name="resource_pattern" class="boxTF" style="width: 98%;" value="${dto.resource_pattern}">
	         </p>
	         <p class="help-block">
	              url 타입은 「/bbs/**」 나 「/bbs/list」 형식으로 입력합니다.<br>
	              만약, url 패턴에 「**」이 있는 경우 하위 경로까지 적용됩니다.
	         </p>
	   </td>			
	</tr>

   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">리소스 타입</label>
	   </td>
	   <td style="padding: 0 0 15px 15px;">
	         <p style="margin-bottom: 5px;">
	             <select name="resource_type" class="selectField">
           		     <option value="url" ${vo.resource_type=="url"?"selected='selected'":""}>url(웹 주소)</option>
           		     <!--
           		     <option value="method" ${vo.resource_type=="method"?"selected='selected'":""}>method(자바 메소드)</option>
           		     <option value="pointcut" ${vo.resource_type=="pointcut"?"selected='selected'":""}>pointcut(AOP)</option>
           		     -->
               </select>
	         </p>
	   </td>			
	</tr>

   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">정렬 순서</label>
	   </td>
	   <td style="padding: 0 0 15px 15px;">
	         <p style="margin-bottom: 5px;">
	             <input type="text" name="sort_order" class="boxTF" style="width: 98%;" value="${empty dto.sort_order ? '1':dto.sort_order}">
	         </p>
	         <p class="help-block">
	              패턴에 「/bbs/**」와 「/bbs/list」 가 모두 존재하는 경우<br>
	              「**」가 있는 패턴의 정렬순서가 더 커야 합니다.
	         </p>
	   </td>			
	</tr>

   <tr>
	   <td width="90" valign="top" style="text-align: right; padding-top: 5px;">
		     <label style="font-weight: 900;">패턴 설명</label>
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
		<input type="hidden" name="resource_id" value="${dto.resource_id}">  
  </c:if>
  <input type="hidden" name="mode" value="${mode}">
</form>
