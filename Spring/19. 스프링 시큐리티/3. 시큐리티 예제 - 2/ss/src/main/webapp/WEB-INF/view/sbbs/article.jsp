<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.alert-info {
    border: 1px solid #9acfea;
    border-radius: 4px;
    background-color: #d9edf7;
    color: #31708f;
    padding: 15px;
    margin-top: 10px;
    margin-bottom: 20px;
}
</style>

<script type="text/javascript">
function deleteBoard() {
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}">
	var query = "num=${dto.num}&${query}";
	var url = "<%=cp%>/sbbs/delete?" + query;

	if(confirm("위 자료를 삭제 하시 겠습니까 ? ")) {
			location.href=url;
	}
</c:if>    
<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!=dto.userId}">
	alert("게시물을 삭제할 수  없습니다.");
</c:if>
}

function updateBoard() {
<c:if test="${sessionScope.member.userId==dto.userId}">
	var query = "num=${dto.num}&group=${group}&page=${page}";
	var url = "<%=cp%>/sbbs/update?" + query;

	location.href=url;
</c:if>

<c:if test="${sessionScope.member.userId!=dto.userId}">
	alert("게시물을 수정할 수  없습니다.");
</c:if>
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

// 페이징 처리
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "<%=cp%>/sbbs/listReply";
	var query = "num=${dto.num}&pageNo="+page;
	var selector = "#listReply";
	
	ajaxHTML(url, "get", query, selector);
}

// 댓글 등록
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
		
		var url="<%=cp%>/sbbs/insertReply";
		var query="num="+num+"&content="+content;
		
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
		
		var url="<%=cp%>/sbbs/deleteReply";
		var query="replyNum="+replyNum;
		
		var fn = function(data){
			// var state=data.state;
			listPage(page);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});
</script>

<div class="body-container" style="width: 700px;">
	<div class="body-title">
		<h3><i class="fas fa-chalkboard-teacher"></i> 스터디 질문과 답변 </h3>
	</div>

	<div>
		<div class="alert-info">
		    <i class="fas fa-info-circle"></i>
		    풀리지 않는 문제를 공유해서 해결할 수 있는 공간입니다. 
		</div>
	
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
		<tr height="35" style="border-top: 1px solid #cccccc;  border-bottom: 1px solid #cccccc;">
		    <td colspan="2" align="center">
			   ${dto.subject}
		    </td>
		</tr>
		
		<tr height="35" style="border-bottom: 1px solid #cccccc;">
		    <td colspan="2" align="left" style="padding-left: 5px;">
			   분류 : ${dto.groupCategory} &gt; ${dto.category}
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
		
		<tr style="border-bottom: 1px solid #cccccc;">
		  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
		      ${dto.content}
		   </td>
		</tr>
		
		<tr height="35" style="border-bottom: 1px solid #cccccc;">
		    <td colspan="2" align="left" style="padding-left: 5px;">
		       이전글 :
		         <c:if test="${not empty preReadDto}">
		              <a href="<%=cp%>/sbbs/article?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
		        </c:if>
		    </td>
		</tr>
		
		<tr height="35" style="border-bottom: 1px solid #cccccc;">
		    <td colspan="2" align="left" style="padding-left: 5px;">
		       다음글 :
		         <c:if test="${not empty nextReadDto}">
		              <a href="<%=cp%>/sbbs/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
		        </c:if>
		    </td>
		</tr>
		</table>
		
		<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
		<tr height="45">
		    <td width="300" align="left">
	          <button type="button" class="btn" onclick="updateBoard();" style="${sessionScope.member.userId==dto.userId ? ';':'pointer-events: none; color : #cccccc;'} ">수정</button>
	          <button type="button" class="btn" onclick="deleteBoard();" style="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin' ? '':'pointer-events: none; color : #cccccc;'}">삭제</button>
		    </td>
		
		    <td align="right">
		        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/sbbs/list?${query}';">리스트</button>
		    </td>
		</tr>
		</table>
    </div>
    
    <div>
		<table style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
			<tr height='30'> 
				 <td align='left' >
				 	<span style='font-weight: bold;' >답글달기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
				 </td>
			</tr>
			<tr>
			   	<td style='padding:5px 5px 0px;'>
					<textarea class='boxTA' style='width:99%; height: 70px;'></textarea>
			    </td>
			</tr>
			<tr>
			   <td align='right'>
			        <button type='button' class='btn btnSendReply' style='padding:10px 20px;'>답글 등록</button>
			    </td>
			 </tr>
		</table>
		     
		<div id="listReply"></div>
    
    </div>
    
</div>
