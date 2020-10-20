package com.tag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class Paginate extends TagSupport {
	private static final long serialVersionUID = 1L;
	
	private Integer current_page, total_page;
	private String uri;
	public void setCurrent_page(Integer current_page) {
		this.current_page = current_page;
	}
	public void setTotal_page(Integer total_page) {
		this.total_page = total_page;
	}
	public void setUri(String uri) {
		this.uri = uri;
	}
	
	@Override
	public int doStartTag() throws JspException {
		JspWriter out=pageContext.getOut();
		
		try {
			out.print(paging());
		} catch (Exception e) {
		}
		
		return SKIP_BODY;
	}

	@Override
	public int doEndTag() throws JspException {
		current_page=null;
		total_page=null;
		uri=null;
		
		return EVAL_PAGE;
	}
	private String paging() {
		StringBuffer sb=new StringBuffer();
		
		int numPerBlock=10;
		int currentPageSetup;
		int n, page;
		
		if(current_page<1 || total_page < 1)
			return "";
		
		if(uri.indexOf("?")!=-1)
			uri+="&";
		else
			uri+="?";
		
		// currentPageSetup : 표시할첫페이지-1
		currentPageSetup=(current_page/numPerBlock)*numPerBlock;
		if(current_page%numPerBlock==0)
			currentPageSetup=currentPageSetup-numPerBlock;

		sb.append("<style type='text/css'>");
		sb.append("#paginate {clear:both; font:10pt; font-family: 맑은 고딕,돋움;text-align:center;white-space:nowrap;}");
		sb.append("#paginate a {color:#000000; text-decoration:none; padding:6px 3px;}");
		sb.append("#paginate a:hover, a:active {color:#6771ff;}");
		sb.append("#paginate .curBox {color:#cb3536; padding:6px 3px;}");
		sb.append("#paginate .numBox {text-decoration:none;padding:6px 3px;}");
		sb.append("</style>");
		
		sb.append("<div id='paginate'>");
		// 1 [Prev]
		n=current_page-numPerBlock;
		if(total_page > numPerBlock && currentPageSetup > 0) {
			sb.append("<a href='"+uri+"page=1'>처음</a>");
			sb.append("<a href='"+uri+"page="+n+"'>이전</a>");
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
		
		// [Next] 마지막페이지
		n=current_page+numPerBlock;
		if(n>total_page) n=total_page;
		if(total_page-currentPageSetup>numPerBlock) {
			sb.append("<a href='"+uri+"page="+n+"'>다음</a>");
			sb.append("<a href='"+uri+"page="+total_page+"'>끝</a>");
		}
		sb.append("</div>");
	
		return sb.toString();
	}
}
