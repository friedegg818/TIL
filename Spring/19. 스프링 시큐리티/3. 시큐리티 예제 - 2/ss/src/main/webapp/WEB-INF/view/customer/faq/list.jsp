<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
$(function(){
	$(".answer").hide();
	$(".question").each(function(index){
		$(this).click(function(){
			var isHidden = $(".answer").eq(index).is(':hidden');
			$(".answer").hide();
			
			if(isHidden) {
				$(".answer").eq(index).show();
			} else {
				$(".answer").eq(index).hide();
			}
		});
	});
});
</script>

<table style="width: 100%; margin: 20px auto 0; border-spacing: 0px; border-collapse: collapse;">
 
<c:forEach var="dto" items="${list}">
	<tr height="35" class="question" bgcolor="#eeeeee">
		<td width="120" style="padding-left: 5px; border:1px solid #cccccc; border-right:none;">
			${dto.category}
		</td>
		<td align="left" class="question-subject" style="padding-right: 5px; border:1px solid #cccccc; border-left:none;">
			| <a href="#">${dto.subject}</a>
		</td>
	</tr>
	<tr height="50" class="answer">
		<td colspan="2" style="padding: 5px; border:1px solid #cccccc; border-top:none;">
			<div style="min-height: 50px;">${dto.content}</div>
				<c:if test="${sessionScope.member.userId=='admin'}">
					<div style="padding-top: 5px; text-align: right;">
						<a onclick="javascript:location.href='<%=cp%>/faq/update?num=${dto.num}&pageNo=${pageNo}';">수정</a>&nbsp;|
						<a onclick="deleteFaq('${dto.num}', '${pageNo}');">삭제</a>
					</div>
				</c:if>
		</td>
	</tr>
	<tr height="3">
		<td colspan="2"></td>
	</tr>
</c:forEach>
</table>
 
<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
   <tr height="35">
	<td align="center">
       ${dataCount==0?"등록된 게시물이 없습니다.":paging}
	</td>
   </tr>
</table>

<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
   <tr height="40">
      <td align="left" width="100">
          <button type="button" class="btn" onclick="reloadFaq();">새로고침</button>
      </td>
      <td align="center">
          <form name="searchForm" action="" method="post">
              <select id="condition" name="condition" class="selectField">
                  <option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
                  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
            </select>
            <input type="text" id="keyword" name="keyword" class="boxTF" value="${keyword}">
            <button type="button" class="btn" onclick="searchList();">검색</button>
        </form>
      </td>
      <td align="right" width="100">
      	<c:if test="${sessionScope.member.userId=='admin'}">
          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/faq/created';">글올리기</button>
        </c:if>
      </td>
   </tr>
</table>
