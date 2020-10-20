<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.boardManage-list {
	cursor: pointer;
}
</style>

<script type="text/javascript">
$(function(){
	$(".boardManage-detail").hide();
	$(".boardManage-list").each(function(index){
		$(this).click(function(){
			var isHidden = $(".boardManage-detail").eq(index).is(':hidden');
			$(".boardManage-detail").hide();
			
			if(isHidden)
				$(".boardManage-detail").eq(index).show();
			else
				$(".boardManage-detail").eq(index).hide();
		});
	});
});

function updateData(num) {
	var url="<%=cp%>/admin/boardManage/update?num="+num;
	location.href=url;
}

function deleteData(num) {
	if(confirm("삭제하시겠습니까 ?")) {
		var url="<%=cp%>/admin/boardManage/delete?num="+num;
		location.href=url;
	}
}
</script>

<div class="body-container" style="width: 750px;">
	<div class="body-title">
		<h3><span style="font-family: Webdings">2</span> 게시판관리 </h3>
	</div>

	<div>
		<div class="alert-info">
			<i class="fas fa-exclamation-circle"></i> 게시판을 동적으로 생성하거나 수정, 삭제 할수 있습니다.
		</div>

		<table style="width: 100%; margin: 20px auto 5px; border-spacing: 0px;">
			<tr height="40">
				<td align="left" width="50%">
					&nbsp;
				</td>
				<td align="right" width="50%">
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/admin/boardManage/created';">게시판생성</button>
				</td>
			</tr>
		</table>
           
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			<tr align="center" bgcolor="#eeeeee" height="35"> 
				<th style="width: 50px; color: #787878; border:1px solid #cccccc; border-right:none;">번호</th>
				<th style="color: #787878; border:1px solid #cccccc; border-left:none; border-right:none;">게시판제목</th>
				<th style="width: 120px; color: #787878; border:1px solid #cccccc; border-left:none; border-right:none;">게시판주소</th>
				<th style="width: 120px; color: #787878; border:1px solid #cccccc; border-left:none; border-right:none;">테이블명</th>
				<th style="width: 100px; color: #787878; border:1px solid #cccccc; border-left:none; border-right:none;">글쓰기권한</th>
				<th style="width: 100px; color: #787878; border:1px solid #cccccc; border-left:none; border-right:none;">답변권한</th>
				<th style="width: 100px; color: #787878; border:1px solid #cccccc; border-left:none;">등록일</th>
			</tr>

<c:forEach var="dto" items="${list}" varStatus="status">			  
			<tr height="3"><td colspan="7"></td></tr>
			<tr height="35" class="boardManage-list" align="center">
				<td style="border:1px solid #cccccc; border-right:none;">
					${status.count}
				</td>
				<td style="border:1px solid #cccccc; border-left:none; border-right:none;">
					${dto.title}
				</td>
				<td style="border:1px solid #cccccc; border-left:none; border-right:none;">
					/cb/${dto.board}/list
				</td>
				<td style="border:1px solid #cccccc; border-left:none; border-right:none;">
					${dto.board}
				</td>
				<td style="border:1px solid #cccccc; border-left:none; border-right:none;">
					${dto.updateMembershipName}
				</td>
				<td style="border:1px solid #cccccc; border-left:none; border-right:none;">
					${dto.answer==1?dto.answerMembershipName:""}
				</td>
				<td style="border:1px solid #cccccc; border-left:none;">
					${dto.created}
				</td>
			</tr>
			<tr height="50" class="boardManage-detail">
				<td colspan="7" style="border:1px solid #cccccc; border-top:none; padding: 5px;">
					<div>
						<span style="display: inline-block;width: 170px;">답변 :
							${dto.answer==1?"O":"X"}
			        	</span>
						<span style="display: inline-block;width: 170px;">아이콘 :
							${dto.icon}
						</span>
						<span style="display: inline-block;width: 170px;">1 페이지 공지 : 
							${dto.notice==1?"O":"X"}
						</span>
						<span style="display: inline-block;width: 170px;">첨부파일 :
							${dto.attach==1?"O":"X"}
						</span>
					</div>
					<div>
						<span style="display: inline-block;width: 170px;">좋아요 : 
							${dto.boardLike==1?"O":"X"}
						</span>
						<span style="display: inline-block;width: 170px;">리플 :
							${dto.reply==1?"O":"X"}
						</span>
						<span style="display: inline-block;width: 170px;">리플좋아요 :
							${dto.replyLike==1?"O":"X"}
						</span>
					</div>
					<div style="clear: both; margin-top: 10px;">
						<span style="display: inline-block; float: left">게시판정보(메시지) : ${dto.info}</span>
						<span style="display: inline-block; float: right">
							<button type="button" class="btn"
								onclick="updateData('${dto.num}');">수정</button>
							<button type="button" class="btn"
								onclick="deleteData('${dto.num}');">삭제</button>
						</span>
					</div>
				</td>
			</tr>
</c:forEach>	   
		</table>
           
	</div>
</div>
