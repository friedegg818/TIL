<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<form id="deteailedMemberForm" name="deteailedMemberForm" method="post">
<table style="margin: 10px auto 0px; width: 100%; border-spacing: 1px; background: #cccccc">
<tr height="37" style="background: #ffffff;">
    <td align="right" width="17%" style="padding-right: 7px;"><label style="font-weight: 900;">아이디</label></td>
    <td align="left" width="33%" style="padding-left: 5px;"><span>${dto.userId}</span></td>
    <td align="right" width="17%" style="padding-right: 7px;"><label style="font-weight: 900;">이름</label></td>
    <td align="left" width="33%" style="padding-left: 5px;"><span>${dto.userName}</span></td>
</tr>
<tr height="37" style="background: #ffffff;">
    <td align="right" width="17%" style="padding-right: 7px;"><label style="font-weight: 900;">생년월일</label></td>
    <td align="left" width="33%" style="padding-left: 5px;"><span>${dto.birth}</span></td>
    <td align="right" width="17%" style="padding-right: 7px;"><label style="font-weight: 900;">전화번호</label></td>
    <td align="left" width="33%" style="padding-left: 5px;"><span>${dto.tel}</span></td>
</tr>
<tr height="37" style="background: #ffffff;">
    <td align="right" width="17%" style="padding-right: 7px;"><label style="font-weight: 900;">이메일</label></td>
    <td align="left" colspan="3" style="padding-left: 5px;"><span>${dto.email}</span></td>
</tr>
<tr height="37" style="background: #ffffff;">
    <td align="right" width="17%" style="padding-right: 7px;"><label style="font-weight: 900;">계정</label></td>
    <td align="left" colspan="3" style="padding-left: 5px;">
          <select name="enabled" class="selectField">
          		<option value="1" ${dto.enabled==1?"selected='selected'":""}>활성</option>
          		<option value="0" ${dto.enabled==0?"selected='selected'":""}>잠금</option>
          </select>
    </td>
</tr>
<tr height="37" style="background: #ffffff;">
    <td align="right" width="17%" style="padding-right: 7px;"><label style="font-weight: 900;">역할</label></td>
    <td align="left" colspan="3" style="padding-left: 5px;">
          <select name="authority" class="selectField">
             <c:forEach var="vo" items="${listRoles}">
             		<option value="${vo.authority}" ${dto.role_name==vo.role_name?"selected='selected'":""}>${vo.role_name}</option>
             </c:forEach>
          </select>
    </td>
</tr>
<tr height="37" style="background: #ffffff;">
    <td align="right" width="17%" style="padding-right: 7px;"><label style="font-weight: 900;">회원가입일</label></td>
    <td align="left" colspan="3" style="padding-left: 5px;"><span>${dto.created_date}</span></td>
</tr>
<tr height="37" style="background: #ffffff;">
    <td align="right" width="17%" style="padding-right: 7px;"><label style="font-weight: 900;">정보수정일</label></td>
    <td align="left" colspan="3" style="padding-left: 5px;"><span>${dto.modify_date}</span></td>
</tr>
<tr height="37" style="background: #ffffff;">
    <td align="right" width="17%" style="padding-right: 7px;"><label style="font-weight: 900;">최근로그인</label></td>
    <td align="left" colspan="3" style="padding-left: 5px;"><span>${dto.last_login}</span></td>
</tr>
</table>
<input type="hidden" name="userId" value="${dto.userId}">
<input type="hidden" name="oldAuthority" value="${dto.authority}">
</form>