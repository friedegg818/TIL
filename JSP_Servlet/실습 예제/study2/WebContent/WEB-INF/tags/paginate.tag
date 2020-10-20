<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="uri" required="true" %>
<%@ attribute name="current_page" required="true" type="Integer"%>
<%@ attribute name="total_page" required="true" type="Integer"%>

<%
	StringBuffer sb=new StringBuffer();
	
	int numPerBlock=10;
	int currentPageSetup;
	int n, page;
	
	if(current_page < 1 || total_page < 1)
	    return;
	
	if(uri.indexOf("?")!=-1)
		uri+="&";
	else
		uri+="?";
	
	// currentPageSetup : 표시할첫페이지-1
	currentPageSetup=(current_page/numPerBlock)*numPerBlock;
	if(current_page%numPerBlock==0)
	    currentPageSetup=currentPageSetup-numPerBlock;
	
	sb.append("<div id='paginate'>");
	// 처음페이지, 이전(10페이지 전)
	n=current_page-numPerBlock;
	if(total_page > numPerBlock && currentPageSetup > 0) {
	    sb.append("<a href='"+uri+"page=1' class='txtBox'>처음</a>");
	    sb.append("<a href='"+uri+"page="+n+"' class='txtBox'>이전</a>");
	}
	
	// 바로가기
	page=currentPageSetup+1;
	while(page<=total_page && page <=(currentPageSetup+numPerBlock)) {
	    if(page==current_page) {
	        sb.append("<span class='curBox'>"+page+"</span>");
	    } else {
	        sb.append("<a href='"+uri+"page="+page+"' class='numBox'>"+page+"</a>");
	    }
	    page++;
	}
	
	// 다음(10페이지 후), 마지막페이지
	n=current_page+numPerBlock;
	if(n>total_page) n=total_page;
	if(total_page-currentPageSetup>numPerBlock) {
	    sb.append("<a href='"+uri+"page="+n+"' class='txtBox'>다음</a>");
	    sb.append("<a href='"+uri+"page="+total_page+"' class='txtBox'>끝</a>");
	}
	sb.append("</div>");
%>

<style type='text/css'>
#paginate {
	clear:both;
	text-align:center;
	height:28px;
	white-space:nowrap;
	font-size: 14px;
	font-family: "Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
}

#paginate a {
	border:1px solid #cccccc;
	height:28px;
	color:#000000;
	text-decoration:none;
	padding:4px 7px 4px 7px;
	margin-left:3px;
	line-height:normal;
	vertical-align:middle;
	outline:none; 
	select-dummy: expression(this.hideFocus=true);
}

#paginate a:hover, a:active {
	color:#6771ff;
}

#paginate .curBox {
	border:1px solid #e28d8d;
	background: #ffffff;
	color:#cb3536;
	font-weight:bold;
	height:28px;
	padding:4px 7px 4px 7px;
	margin-left:3px;
	line-height:normal;
	vertical-align:middle;
}
#paginate .numBox {
	border:1px solid #cccccc;
	font-weight:bold;
}
</style>
<%=sb.toString()%>
