<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
<c:if test="${bm.attach=='1'}">
$(function(){
	$("form input[name=upload]").change(function(){
	// $("body").on("change", "form input[name=upload]", function(){
		if(! $(this).val()) return;

		var returnValue=false;
		$("form input[name=upload]").each(function(){
			if(! $(this).val()) {
				returnValue=true;
				return false;
			}
		});
		if(returnValue) return false;
            
		// clone(true) : 복제(true:이벤트 핸들러도 복제)
		var $tr = $(this).closest("tr").clone(true);
		$tr.find("input").val("");
		$("#tb").append($tr);
	});
});
</c:if>

function sendBoard() {
	var f = document.boardForm;

	var str = f.subject.value;
	if(!str) {
		alert("제목을 입력하세요. ");
		f.subject.focus();
		return;
	}

	str = f.content.value;
	if(!str) {
		alert("내용을 입력하세요. ");
		f.content.focus();
		return;
	}

	f.action="${uri}/${mode}";
	f.submit();
}

<c:if test="${mode=='update' && bm.attach=='1'}">
function deleteFile(fileNum) {
	var url="${uri}/deleteFile";
	$.post(url, {fileNum:fileNum}, function(data){
		$("#f"+fileNum).remove();
	}, "json");
}
</c:if>
</script>

<div class="body-container" style="width: 700px;">
	<div class="body-title">
		<h3>${bm.icon==null?"<span style='font-family: Webdings'>2</span>":bm.icon}&nbsp;${bm.title} </h3>
	</div>
     
	<div>
<c:if test="${not empty bm.info}">
		<div class="alert-info">
			<i class="fas fa-exclamation-circle"></i> ${bm.info}
		</div>
</c:if>
		<form name="boardForm" method="post" enctype="multipart/form-data">
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tbody id="tb">	
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
					<td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
					<td style="padding-left:10px;"> 
						<input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.subject}">
					</td>
				</tr>
<c:if test="${bm.notice=='1' && mode!='answer'}">			
				<tr height="40" style="border-bottom: 1px solid #cccccc;"> 
					<td width="100" bgcolor="#eeeeee" style="text-align: center;">공지여부</td>
					<td style="padding-left:10px;"> 
						<input type="checkbox" name="notice" value="1" ${dto.notice==1 ? "checked='checked' ":"" } > 공지
					</td>
				</tr>
</c:if>
				<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
					<td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
					<td style="padding-left:10px;"> 
						${sessionScope.member.userName}
					</td>
				</tr>
			
				<tr align="left" style="border-bottom: 1px solid #cccccc;"> 
					<td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
					<td valign="top" style="padding:5px 0px 5px 10px;"> 
						<textarea name="content" id="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
					</td>
				</tr>
<c:if test="${bm.attach=='1'}">			  
				<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					<td width="100" bgcolor="#eeeeee" style="text-align: center;">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
					<td style="padding-left:10px;"> 
						<input type="file" name="upload" class="boxTF" size="53" style="width: 95%; height: 25px;">
					</td>
				</tr>
</c:if>			  
			</tbody>
<c:if test="${mode=='update'}">
			<c:forEach var="vo" items="${listFile}">
				<tr id="f${vo.fileNum}" height="40" style="border-bottom: 1px solid #cccccc;"> 
					<td width="100" bgcolor="#eeeeee" style="text-align: center;">첨부된파일</td>
					<td style="padding-left:10px;"> 
						<a href="javascript:deleteFile('${vo.fileNum}');"><i class="far fa-trash-alt"></i> ${vo.originalFilename}</a> 
					</td>
				</tr>
			</c:forEach>
</c:if>
			</table>
			
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
				<tr height="45"> 
					<td align="center" >
						<button type="button" class="btn" onclick="sendBoard();">${mode=='update'?'수정완료':'등록하기'}</button>
						<button type="reset" class="btn">다시입력</button>
						<button type="button" class="btn" onclick="javascript:location.href='${uri}/list';">${mode=='update'?'수정취소':'등록취소'}</button>
						<c:if test="${mode=='update'}">
							<input type="hidden" name="num" value="${dto.num}">
							<input type="hidden" name="page" value="${page}">
						</c:if>
						<c:if test="${mode=='answer'}">
							<input type="hidden" name="page" value="${page}">
							<input type="hidden" name="groupNum" value="${dto.groupNum}">
							<input type="hidden" name="orderNo" value="${dto.orderNo}">
							<input type="hidden" name="depth" value="${dto.depth}">
							<input type="hidden" name="parent" value="${dto.num}">
						</c:if>
					</td>
				</tr>
			</table>
		</form>
	</div>
     
</div>
