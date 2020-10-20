<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<style type="text/css">
.ui-widget-header {
	background: none;
	border: none;
	height:35px;
	line-height:35px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;
}

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
$(function(){
	var categoryNum = "${categoryNum}";
	var pageNo="${pageNo}";
	if(pageNo=="") {
		pageNo=1;
	}
	$("#tab-"+categoryNum).addClass("active");
	listPage(pageNo);

	$("ul.tabs li").click(function() {
		categoryNum = $(this).attr("data-categoryNum");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+categoryNum).addClass("active");
		
		listPage(1);
	});
});

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
			if($.trim(data)=="error") {
				listPage(1);
				return false;
			}	
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

// 글리스트 및 페이징 처리
function listPage(page) {
	var $tab = $(".tabs .active");
	var categoryNum = $tab.attr("data-categoryNum");
	
	var url="<%=cp%>/faq/list";
	var query="pageNo="+page+"&categoryNum="+categoryNum;
	var search=$('form[name=faqSearchForm]').serialize();
	query=query+"&"+search;
	
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

// 검색
function searchList() {
	var f=document.faqSearchForm;
	f.condition.value=$("#condition").val();
	f.keyword.value=$.trim($("#keyword").val());

	listPage(1);
}

// 새로고침
function reloadFaq() {
	var f=document.faqSearchForm;
	f.condition.value="all";
	f.keyword.value="";
	
	listPage(1);
}

// 글 삭제
function deleteFaq(num, page) {
	var url="<%=cp%>/faq/delete";
	
	var query="num="+num;
	
	if(! confirm("위 게시물을 삭제 하시 겠습니까 ? ")) {
		  return;
	}
	
	var fn = function(data){
		listPage(page);
	};
	
	ajaxJSON(url, "post", query, fn);		
}
</script>

<div class="body-container" style="width: 800px;">
    <div class="body-title">
        <h3><i class="fas fa-exclamation-triangle"></i> 자주하는 질문 </h3>
    </div>
    
	<div class="alert-info">
	   <i class="fas fa-info-circle"></i>
	     궁금한 문의 사항을 빠르게 검색 할 수 있습니다.
	</div>
    
    <div>
            <div style="clear: both;">
	           <ul class="tabs"> 
	           	   <li id="tab-0" data-categoryNum="0">모두</li>
	           	   <c:forEach var="dto" items="${listCategory}">
			       		<li id="tab-${dto.categoryNum}" data-categoryNum="${dto.categoryNum}">${dto.category}</li>
	           	   </c:forEach>
			   </ul>
		   </div>
		   <div id="tab-content" style="clear:both; padding: 20px 10px 0px;"></div>
    </div>
</div>

<form name="faqSearchForm" method="post">
    <input type="hidden" name="condition" value="all">
    <input type="hidden" name="keyword" value="">
</form>
