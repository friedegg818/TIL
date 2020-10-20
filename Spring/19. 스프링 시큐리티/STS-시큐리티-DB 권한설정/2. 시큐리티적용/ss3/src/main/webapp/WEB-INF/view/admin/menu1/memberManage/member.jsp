<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
/* 모달대화상자 타이틀바 */
.ui-widget-header {
	background: none;
	border: none;
	height:35px;
	line-height:35px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;
}
.hover-tr:hover {
	cursor: pointer;
	background: #fffdfd;
}
</style>

<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.enabled.value=$("#selectEnabled").val();
		f.action="<%=cp%>/admin/memberManage/member";
		f.submit();
	}
	
	function detailedMember(userId) {
		var dlg = $("#member-dialog").dialog({
			  autoOpen: false,
			  modal: true,
			  buttons: {
			       " 수정 " : function() {
			    	   updateOk(); 
			       },
			       " 삭제 " : function() {
			    	   deleteOk(userId);
				   },
			       " 닫기 " : function() {
			    	   $(this).dialog("close");
			       }
			  },
			  height: 460,
			  width: 600,
			  title: "회원상세정보",
			  close: function(event, ui) {
			  }
		});
		
		var url = "<%=cp%>/admin/memberManage/detailedMember";
		var query = "userId="+userId;
		$.ajax({
            url : url,
            data : query,
            type : 'post',
            success : function(data) {
            	$('#member-dialog').html(data);
            	dlg.dialog("open");
            },
            beforeSend : function(jqXHR) {
                // 서버에 요청하기 전에 "AJAX"라는 이름의 헤더 추가 
                jqXHR.setRequestHeader("AJAX", true);
            },
            error : function(jqXHR) {
                if (jqXHR.status == 401) {
                	console.log(jqXHR);
                } else if (jqXHR.status == 403) { // 로그인이 되지 않은 경우
                    location.href="<%=cp%>/member/login";
                } else {
                	console.log(jqXHR);
                }
            }
        });
	}
	
	function updateOk() {
		var url = "<%=cp%>/admin/memberManage/updateMember";
		var query=$("#deteailedMemberForm").serialize();
		$.ajax({
            url : url,
            data : query,
            type : 'post',
            success : function(data) {
            	$("form input[name=page]").val("${page}");
            	searchList();
            },
            beforeSend : function(jqXHR) {
                // 서버에 요청하기 전에 "AJAX"라는 이름의 헤더 추가 
                jqXHR.setRequestHeader("AJAX", true);
            },
            error : function(jqXHR) {
                if (jqXHR.status == 401) {
                	console.log(jqXHR);
                } else if (jqXHR.status == 403) {
                    location.href="<%=cp%>/member/login";
                } else {
                	console.log(jqXHR);
                }
            }
        });		
		
		$('#member-dialog').dialog("close");
	}
	
	function deleteOk(userId) {
		$('#member-dialog').dialog("close");
	}
</script>

<div class="body-content-container">
     <div class="body-title">
         <h3><span style="font-family: Webdings">2</span> 회원관리 </h3>
     </div>
     
     <div>
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			   <tr height="35">
			      <td align="left" width="50%">
			          ${dataCount}개(${page}/${total_page} 페이지)
			      </td>
			      <td align="right">
			          <select id="selectEnabled" class="selectField" onchange="searchList();">
			          		<option value="" ${enabled=="" ? "selected='selected'":""}>전체보기</option>
			          		<option value="0" ${enabled=="0" ? "selected='selected'":""}>잠금 계정</option>
			          		<option value="1" ${enabled=="1" ? "selected='selected'":""}>활성 계정</option>
			          </select>
			      </td>
			   </tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			  <tr><td height="1" colspan="8" bgcolor="#cccccc"></td></tr>
			  <tr align="center" bgcolor="#eeeeee" height="35"> 
			      <th style="width: 60px; color: #787878;">번호</th>
			      <th style="width: 100px; color: #787878;">아이디</th>
			      <th style="width: 90px; color: #787878;">이름</th>
			      <th style="width: 100px; color: #787878;">생년월일</th>
			      <th style="width: 120px; color: #787878;">전화번호</th>
			      <th style="width: 150px; color: #787878;">역할</th>
			      <th style="width: 60px; color: #787878;">계정</th>
			      <th style="color: #787878;">이메일</th>
			  </tr>
			  <tr><td height="1" colspan="8" bgcolor="#cccccc"></td></tr>
			 
			 <c:forEach var="dto" items="${list}">
			  <tr align="center" bgcolor="#ffffff" height="35" class="hover-tr"
			        onclick="detailedMember('${dto.userId}');"> 
			      <td align="center">${dto.listNum}</td>
			      <td align="center">${dto.userId}</td>
			      <td align="center">${dto.userName}</td>
			      <td align="center">${dto.birth}</td>
			      <td align="center">${dto.tel}</td>
			      <td align="center">${dto.role_name}</td>
			      <td align="center">
			      	     ${dto.enabled==1?"활성":"잠금"}
			      </td>
			      <td align="center">${dto.email}</td>
			  </tr>
			  <tr><td height="1" colspan="8" bgcolor="#cccccc"></td></tr> 
			</c:forEach> 
			</table>
			 
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			   <tr height="40">
				<td align="center">
					${dataCount==0?"등록된 자료가 없습니다.":paging}
				</td>
			   </tr>
			</table>
			
			<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			   <tr height="40">
			      <td align="left" width="100">
			          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/admin/memberManage/member';">새로고침</button>
			      </td>
			      <td align="center">
			          <form name="searchForm" action="" method="post">
			              <select name="condition" class="selectField">
			                  <option value="userId"       ${condition=="userId" ? "selected='selected'":""}>아이디</option>
			                  <option value="userName" ${condition=="userName" ? "selected='selected'":""}>이름</option>
			                  <option value="email"        ${condition=="email" ? "selected='selected'":""}>이메일</option>
			                  <option value="tel"             ${condition=="tel" ? "selected='selected'":""}>전화번호</option>
			                  <option value="role_name" ${condition=="role_name" ? "selected='selected'":""}>역할</option>
			            </select>
			            <input type="text" name="keyword" class="boxTF" value="${keyword}">
			            <input type="hidden" name="enabled" value="${enabled}">
			            <input type="hidden" name="page" value="1">
			            <button type="button" class="btn" onclick="searchList()">검색</button>
			        </form>
			      </td>
			      <td align="right" width="100">&nbsp;</td>
			   </tr>
			</table>
			
     </div>
</div>

<div id="member-dialog" style="display: none;">
	
</div>
