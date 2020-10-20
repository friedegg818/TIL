<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
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

tr.over {
	background: #f5fffa;
	cursor: pointer;
}
</style>

<script type="text/javascript">
$(function(){
	$("#tab-${group}").addClass("active");

	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		var url="<%=cp%>/sbbs/list?group="+tab;	
		location.href=url;
	});
});

$(function(){
	$(".board-list tr").hover(function(){
		$(this).addClass("over");
	}, function(){ // 마우스가 벗어나면
		$(this).removeClass("over");
	});
	
	$(".board-list tr").click(function(){
		var num = $(this).attr("data-num");
		var url="${articleUrl}&num="+num;
		location.href=url;
	});
});

function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>

<div class="body-container" style="width: 800px;">
	<div class="body-title">
		<h3><i class="fas fa-chalkboard-teacher"></i> 스터디 질문과 답변 </h3>
	</div>

	<div>

		<div style="clear: both;">
			<ul class="tabs">
				<li id="tab-0" data-tab="0">전체</li>
				<c:forEach var="vo" items="${groupList}">
					<li id="tab-${vo.categoryNum}" data-tab="${vo.categoryNum}">${vo.category}</li>
				</c:forEach>
			</ul>
		</div>
		<div id="tab-content" style="clear:both; padding: 20px 0px 0px; ">
		
			<div class="alert-info">
			    <i class="fas fa-info-circle"></i>
			    풀리지 않는 문제를 공유해서 해결할 수 있는 공간입니다. 
			</div>
		
			<table style="width: 100%; border-spacing: 0px; margin:0px auto; border-collapse: collapse;">
			  <thead>
			  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <th width="60" style="color: #787878;">번호</th>
			      <th width="130" style="color: #787878;">과목</th>
			      <th style="color: #787878;">제목</th>
			      <th width="90" style="color: #787878;">작성자</th>
			      <th width="80" style="color: #787878;">작성일</th>
			      <th width="60" style="color: #787878;">조회수</th>
			      <th width="50" style="color: #787878;">답변</th>
			  </tr>
			 </thead>
			 <tbody class="board-list" >
			 <c:forEach var="dto" items="${list}">
			  <tr align="center" data-num="${dto.num}" height="35" style="border-bottom: 1px solid #cccccc;"> 
			      <td>${dto.listNum}</td>
			      <td>${dto.category}</td>
			      <td align="left"style="padding-left: 10px;">
			           <div style="width:320px; white-space: nowrap; overflow:hidden; text-overflow:ellipsis;" title="${dto.subject}">${dto.subject}</div>
			      </td>
			      <td>${dto.userName}</td>
			      <td>${dto.created}</td>
			      <td>${dto.hitCount}</td>
			      <td>
	                    <c:choose>
	                    	<c:when test="${dto.replyCount==0}">대기</c:when>
	                    	<c:otherwise>완료</c:otherwise>
	                    </c:choose>
			      </td>
			  </tr>
			  </c:forEach>
			  </tbody>
			</table>
			 
			<table style="width: 100%; border-spacing: 0px;">
			   <tr height="35">
				<td align="center">
				       ${dataCount==0?"등록된 게시물이 없습니다.":paging}
				 </td>
			   </tr>
			</table>
			
			<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			   <tr height="40">
			      <td align="left" width="100">
			          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/sbbs/list?group=${group}';">새로고침</button>
			      </td>
			      <td align="center">
			          <form name="searchForm" action="<%=cp%>/sbbs/list" method="post">
			              <select name="condition" class="selectField">
			                  <option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
			                  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
			                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
			                  <option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
			                  <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
			            </select>
			            <input type="hidden" name="group" value="${group}">
			            <input type="text" name="keyword" value="${keyword}" class="boxTF">
			            <button type="button" class="btn" onclick="searchList()">검색</button>
			        </form>
			      </td>
	
			      <td align="right" width="100">
			          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/sbbs/created';">글올리기</button>
			      </td>
			   </tr>
			</table>
			
		</div>
		
	</div>

</div>