<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
	}
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
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			<tr height="35">
				<td align="left" width="50%">
					${dataCount}개(${page}/${total_page} 페이지)
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table>

		<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<th style="width: 60px; color: #787878;">번호</th>
				<th style="color: #787878;">제목</th>
				<th style="width: 100px; color: #787878;">작성자</th>
				<th style="width: 100px; color: #787878;">작성일</th>
				<th style="width: 60px; color: #787878;">조회수</th>
			</tr>

		<c:forEach var="dto" items="${listTop}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td><span style="display: inline-block;padding:1px 3px; background: #ED4C00;color: #FFFFFF">공지</span></td>
				<td align="left" style="padding-left: 10px;">
					<a href="${articleUrl}&num=${dto.num}">${dto.subject}</a>
				</td>
				<td>${dto.userName}</td>
				<td>${dto.created}</td>
				<td>${dto.hitCount}</td>
			</tr>
		</c:forEach>

		<c:forEach var="dto" items="${list}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td>${dto.listNum}</td>
				<td align="left" style="padding-left: 10px;">
					<c:forEach var="n" begin="1" end="${dto.depth}">
						&nbsp;
					</c:forEach>
					<c:if test="${dto.depth!=0}">└&nbsp;</c:if>			      
						<a href="${articleUrl}&num=${dto.num}">${dto.subject}<c:if test="${bm.reply=='1'}"> (${dto.replyCount})</c:if></a>
						<c:if test="${dto.gap < 1}">
							<img src='<%=cp%>/resource/images/new.gif'>
						</c:if>
				</td>
				<td>${dto.userName}</td>
				<td>${dto.created}</td>
				<td>${dto.hitCount}</td>
			</tr>
		</c:forEach>
		</table>

		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			<tr height="40">
				<td align="center">
					${dataCount==0?"등록된 게시물이 없습니다.":paging}
				</td>
			</tr>
		</table>

		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			<tr height="40">
				<td align="left" width="100">
					<button type="button" class="btn" onclick="javascript:location.href='${uri}/list';">새로고침</button>
				</td>
				<td align="center">
					<form name="searchForm" action="${uri}/list" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
							<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
							<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
							<option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
							<option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
						</select>
						<input type="text" name="keyword" value="${keyword}" class="boxTF">
						<button type="button" class="btn" onclick="searchList()">검색</button>
					</form>
				</td>
				<td align="right" width="100">
					<c:if test="${not empty sessionScope.member && sessionScope.member.membership>=bm.updateMembership}">
						<button type="button" class="btn" onclick="javascript:location.href='${uri}/created';">글쓰기</button>
					</c:if>
				</td>
			</tr>
		</table>
	</div>

</div>
