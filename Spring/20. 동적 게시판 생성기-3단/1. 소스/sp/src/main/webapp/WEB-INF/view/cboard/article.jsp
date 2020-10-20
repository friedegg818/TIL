<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
function deleteBoard() {
<c:choose>
  <c:when test="${sessionScope.member.membership==99 || (sessionScope.member.membership>=50 && sessionScope.member.membership >= bm.updateMembership) || sessionScope.member.userId==dto.userId}">
      var query = "num=${dto.num}&${query}"
	  var url = "${uri}/delete?" + query;

	  if(confirm("위 자료를 삭제 하시 겠습니까 ? ")) {
	  	location.href=url;
	  }
  </c:when>
  <c:otherwise>
      alert("게시물을 삭제할 수  없습니다.");
  </c:otherwise>
</c:choose>
}

function updateBoard() {
<c:choose>
  <c:when test="${sessionScope.member.userId==dto.userId}">
    var query = "num=${dto.num}&page=${page}";
    var url = "${uri}/update?" + query;

    location.href=url;
  </c:when>
  <c:otherwise>
    alert("게시물을 수정할 수  없습니다.");
  </c:otherwise>
</c:choose>	
}
</script>

<script type="text/javascript">
function login() {
	location.href="<%=cp%>/member/login";
}

function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			$(selector).html(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

<c:if test="${bm.boardLike=='1'}">
//게시글 공감 여부
$(function(){
	$(".btnSendBoardLike").click(function(){
		if(! confirm("게시물에 공감 하십니까 ? ")) {
			return false;
		}
		
		var url="${uri}/insertBoardLike";
		var query="num=${dto.num}&boardLike=1";
		
		var fn = function(data){
			var state=data.state;
			if(state=="true") {
				var count = data.boardLikeCount;
				$("#boardLikeCount").text(count);
			} else if(state=="false") {
				alert("좋아요는 한번만 가능합니다. !!!");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});
</c:if>

<c:if test="${bm.reply=='1'}">
// 댓글 리스트
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="${uri}/listReply";
	var query="num=${dto.num}&pageNo="+page;
	var selector = "#listReply";
	
	ajaxHTML(url, "get", query, selector);
}

// 리플 등록
$(function(){
	$(".btnSendReply").click(function(){
		var num="${dto.num}";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${uri}/insertReply";
		var query="num="+num+"&content="+content+"&answer=0";
		
		var fn = function(data){
			$tb.find("textarea").val("");
			
			var state=data.state;
			if(state=="true") {
				listPage(1);
			} else if(state=="false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

// 댓글 삭제
$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var replyNum=$(this).attr("data-replyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="${uri}/deleteReply";
		var query="replyNum="+replyNum+"&mode=reply";
		
		var fn = function(data){
			// var state=data.state;
			listPage(page);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

//댓글 좋아요 / 싫어요
<c:if test="${bm.replyLike=='1'}">
	$(function(){
		// 댓글 좋아요 / 싫어요 등록
		$("body").on("click", ".btnSendReplyLike", function(){
			var replyNum=$(this).attr("data-replyNum");
			var replyLike=$(this).attr("data-replyLike");
			var $btn = $(this);
			
			var msg="게시물이 마음에 들지 않으십니까 ?";
			if(replyLike==1) {
				msg="게시물에 공감하십니까 ?";
			}
			if(! confirm(msg)) {
				return false;
			}
			
			var url="${uri}/insertReplyLike";
			var query="replyNum="+replyNum+"&replyLike="+replyLike;
			
			var fn = function(data){
				var state=data.state;
				if(state=="true") {
					var likeCount=data.likeCount;
					var disLikeCount=data.disLikeCount;
					
					$btn.parent("td").children().eq(0).find("span").html(likeCount);
					$btn.parent("td").children().eq(1).find("span").html(disLikeCount);
				} else if(state=="false") {
					alert("게시물 공감 여부는 한번만 가능합니다. !!!");
				}
			};
			
			ajaxJSON(url, "post", query, fn);
			
		});
		
	});
</c:if>

// 댓글별 답글 리스트
function listReplyAnswer(answer) {
	var url="${uri}/listReplyAnswer";
	var query = {answer:answer};
	var selector = "#listReplyAnswer"+answer;
	
	ajaxHTML(url, "get", query, selector);
}

// 댓글별 답글 개수
function countReplyAnswer(answer) {
	var url="${uri}/countReplyAnswer";
	var query = {answer:answer};
	
	var fn = function(data){
		var count=data.count;
		var vid="#answerCount"+answer;
		$(vid).html(count);
	};
	
	ajaxJSON(url, "post", query, fn);
}

// 답글 버튼(댓글별 답글 등록폼 및 답글리스트)
$(function(){
	$("body").on("click", ".btnReplyAnswerLayout", function(){
		var $trReplyAnswer = $(this).closest("tr").next();
		
		var isVisible = $trReplyAnswer.is(':visible');
		var replyNum = $(this).attr("data-replyNum");
			
		if(isVisible) {
			$trReplyAnswer.hide();
		} else {
			$trReplyAnswer.show();
            
			// 답글 리스트
			listReplyAnswer(replyNum);
			// 답글 개수
			countReplyAnswer(replyNum);
		}
	});
	
});

// 댓글별 답글 등록
$(function(){
	$("body").on("click", ".btnSendReplyAnswer", function(){
		var num="${dto.num}";
		var replyNum = $(this).attr("data-replyNum");
		var $td = $(this).closest("td");
		var content=$td.find("textarea").val().trim();
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${uri}/insertReply";
		var query="num="+num+"&content="+content+"&answer="+replyNum;
		
		var fn = function(data){
			$td.find("textarea").val("");
			
			var state=data.state;
			if(state=="true") {
				listReplyAnswer(replyNum);
				countReplyAnswer(replyNum);
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

// 댓글별 답글 삭제
$(function(){
	$("body").on("click", ".deleteReplyAnswer", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var replyNum=$(this).attr("data-replyNum");
		var answer=$(this).attr("data-answer");
		
		var url="${uri}/deleteReply";
		var query="replyNum="+replyNum+"&mode=answer";
		
		var fn = function(data){
			listReplyAnswer(answer);
			countReplyAnswer(answer);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});
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
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="center">
					<c:if test="${dto.depth!=0}">[Re]</c:if>
					${dto.subject}
			    </td>
			</tr>

			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td width="50%" align="left" style="padding-left: 5px;">
					이름 : ${dto.userName}
				</td>
				<td width="50%" align="right" style="padding-right: 5px;">
					${dto.created} | 조회 ${dto.hitCount}
				</td>
			</tr>

			<tr ${bm.boardLike=='0'?"style='border-bottom: 1px solid #cccccc;'":""}>
				<td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="150">
					${dto.content}
				</td>
			</tr>
<c:if test="${bm.boardLike=='1'}">
			<tr style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" height="40" style="padding-bottom: 15px;" align="center">
					<button type="button" class="btn btnSendBoardLike" title="좋아요"><i class="fas fa-hand-point-up"></i>&nbsp;&nbsp;<span id="boardLikeCount">${boardLikeCount}</span></button>
				</td>
			</tr>
</c:if>			

<c:forEach var="vo" items="${listFile}">			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					첨&nbsp;&nbsp;부 :
					<c:if test="${not empty vo.saveFilename}">
						<a href="${uri}/download?fileNum=${vo.fileNum}">${vo.originalFilename}</a>
						(<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> KByte)
					</c:if>
				</td>
			</tr>
</c:forEach>

			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					이전글 :
					<c:if test="${not empty preReadDto}">
						<a href="${uri}/article?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
					</c:if>
				</td>
			</tr>

			<tr height="35" style="border-bottom: 1px solid #cccccc;">
				<td colspan="2" align="left" style="padding-left: 5px;">
					다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="${uri}/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
					</c:if>
				</td>
			</tr>
		</table>

		<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
				<td width="300" align="left">
					<c:if test="${bm.answer=='1' && not empty sessionScope.member && sessionScope.member.membership>=bm.answerMembership }">			    
						<button type="button" class="btn" onclick="javascript:location.href='${uri}/answer?num=${dto.num}&page=${page}';">답변</button>
					</c:if>
					<c:if test="${sessionScope.member.userId==dto.userId}">				    
						<button type="button" class="btn" onclick="updateBoard();">수정</button>
					</c:if>
					<c:if test="${sessionScope.member.membership==99 || (sessionScope.member.membership>=50 && sessionScope.member.membership >= bm.updateMembership) || sessionScope.member.userId==dto.userId}">				    
						<button type="button" class="btn" onclick="deleteBoard();">삭제</button>
					</c:if>
				</td>

				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='${uri}/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
	</div>

<c:if test="${bm.reply=='1' }">        
	<div>
		<table style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
			<tr height='30'> 
				<td align='left'>
					<span style='font-weight: bold;' >댓글쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
				</td>
			</tr>
			<tr>
				<td style='padding:5px 5px 0px;'>
					<textarea class='boxTA' style='width:99%; height: 70px;'></textarea>
				</td>
			</tr>
			<tr>
				<td align='right'>
					<button type='button' class='btn btnSendReply' style='padding:10px 20px;'>댓글 등록</button>
				</td>
			</tr>
		</table>

		<div id="listReply"></div>
	</div>
</c:if>
</div>
