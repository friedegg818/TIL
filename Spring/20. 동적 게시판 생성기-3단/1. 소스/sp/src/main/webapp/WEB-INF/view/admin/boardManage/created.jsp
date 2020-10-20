<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.help-block {
	margin-bottom: 5px;
}
</style>

<script type="text/javascript">
  function sendOk() {
        var f = document.boardManageForm;

    	var str = $.trim(f.title.value);
        if(!str) {
            f.title.focus();
            return;
        }
        f.title.value=str;

    	var str = $.trim(f.board.value);
        if(!str) {
            f.board.focus();
            return;
        }

    	if(! /^[a-z]{2,20}$/g.test(str)) { 
    		f.board.focus();
    		return;
    	}
        f.board.value=str;
        
        if(f.answer.checked && f.updateMembership.value > f.answerMembership.value) {
        	f.answerMembership.focus();
        	return;
        } else {
        	// f.answerMembership.value=99;
        }

       f.action = "<%=cp%>/admin/boardManage/${mode}";
            
       f.submit();
  }
  
  $(function(){
	 $("form input[name=answer]").click(function(){
		if($(this).is(":checked")){
			$("#tr-answerMembership").show();
		} else {
			$("#tr-answerMembership").hide();
		}
	 });
  });
</script>

<div class="body-container" style="width: 700px;">
	<div class="body-title">
		<h3><span style="font-family: Webdings">2</span> 게시판관리 </h3>
	</div>

	<div>
		<div class="alert-info">
			<i class="fas fa-exclamation-circle"></i> 게시판을 동적으로 생성하거나 수정, 삭제 할수 있습니다.
		</div>

		<form name="boardManageForm" method="post">
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 800;">게시판 제목</label>
				</td>
				<td style="padding: 0 0 15px 15px;">
					<p style="margin-bottom: 5px;">
						<input type="text" name="title" value="${dto.title}" class="boxTF" style="width: 95%;" required="required">
					</p>
					<p class="help-block">게시판 제목으로, 필수 입력 사항 입니다.</p>
				</td>
			</tr>
			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 800;">게시판 주소</label>
				</td>
				<td style="padding: 0 0 15px 15px;">
					<p style="margin-bottom: 5px;">
						<input type="text" name="board" class="boxTF" style="width: 95%;" 
							value="${dto.board}" ${mode=="update"?"readonly='readonly'":"" }>
					</p>
					<p class="help-block">2~20자 이내의 영어 소문자만 가능하며, 필수 입력 사항 입니다.<br>
						cboard라 입력하면 주소는 /cb/cboard/list, 테이블명은 cboard 가 됩니다.</p>
				</td>
			</tr>
			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 800;">글쓰기 권한</label>
				</td>
				<td style="padding: 0 0 15px 15px;">
					<p style="margin-bottom: 5px;">
						<select name="updateMembership" class="selectField">
							<c:forEach var="vo" items="${listRole}">
								<option value="${vo.membership}" ${dto.updateMembership==vo.membership?"selected='selected'":""}>${vo.memberRole}</option>
							</c:forEach>
						</select>
					</p>
					<p class="help-block">게시물을 등록할 수 있는 권한을 설정 합니다.</p>
				</td>
			</tr>
		       
			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 800;">아이콘</label>
				</td>
				<td style="padding: 0 0 15px 15px;">
					<p style="margin-bottom: 5px;">
						<input type="text" name="icon" class="boxTF" style="width: 95%;" value="${dto.icon}">
					</p>
					<p class="help-block">
						게시판 제목 앞에 표시할 폰트 어썸 아이콘으로, 선택사항 입니다.<br>
						사용예 : <c:out value="<i class='fas fa-chalkboard'></i>"/>
					</p>
				</td>
			</tr>
		       
			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 800;">게시판 정보</label>
				</td>
				<td style="padding: 0 0 15px 15px;">
					<p style="margin-bottom: 5px;">
						<input type="text" name="info" class="boxTF" style="width: 95%;" value="${dto.info}">
					</p>
					<p class="help-block">게시판 제목 아래 부분에 표시되는 정보(메시지)로, 선택사항 입니다.</p>
				</td>
			</tr>

			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 800;">게시판 옵션</label>
				</td>
				<td style="padding: 0 0 15px 15px;">
					<p style="margin-bottom: 5px;">
						<input type="checkbox" name="notice" value="1" ${dto.notice==1?"checked='checked';":"" }> 1페이지 공지&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="answer" value="1" ${dto.answer==1?"checked='checked';":"" }> 답변형&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="attach" value="1" ${dto.attach==1?"checked='checked';":"" }> 파일첨부&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="boardLike" value="1" ${dto.boardLike==1?"checked='checked';":"" }> 좋아요&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="reply" value="1" ${dto.reply==1?"checked='checked';":"" }> 리플형&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="replyLike" value="1" ${dto.replyLike==1?"checked='checked';":"" }> 리플좋아요
					</p>
					<p class="help-block">1페이지 공지, 답변형, 파일 업로드, 리플형, 좋아요  가능 여부를 지정합니다.</p>
				</td>
			</tr>
		       
			<tr id="tr-answerMembership" ${dto.answer==1?"":"style='display:none;'"}>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 800;">답변 권한</label>
				</td>
				<td style="padding: 0 0 15px 15px;">
					<p style="margin-bottom: 5px;">
						<select name="answerMembership" class="selectField">
							<c:forEach var="vo" items="${listRole}">
								<option value="${vo.membership}" ${dto.answerMembership==vo.membership?"selected='selected'":""}>${vo.memberRole}</option>
							</c:forEach>
						</select>
					</p>
					<p class="help-block">게시물의 답변을 등록할 수 있는 권한으로, 글등록 권한 보다 크거나 같아야 합니다.</p>
				</td>
			</tr>

		</table>

		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			<tr height="45"> 
				<td align="center" >
					<button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'생성하기'}</button>
					<button type="reset" class="btn">다시입력</button>
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/admin/boardManage/list';">${mode=='update'?'수정취소':'생성취소'}</button>
					<c:if test="${mode=='update'}">
						<input type="hidden" name="num" value="${dto.num}">
					</c:if>
				</td>
			</tr>
		</table>
		</form>

		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			<tr height="45">
				<td align="center" >
					<span style="color: blue;">${message}</span>
				</td>
			</tr>
		</table>

     </div>
</div>
