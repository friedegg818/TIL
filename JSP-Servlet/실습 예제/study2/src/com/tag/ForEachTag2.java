package com.tag;

import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

public class ForEachTag2 extends TagSupport {
	private static final long serialVersionUID = 1L;
	
	private List<Object> items;
	private String var;
	private int idx = 0;
	
	public void setItems(List<Object> items) {
		this.items = items;
	}
	public void setVar(String var) {
		this.var = var;
	}
	
	@Override
	public int doStartTag() throws JspException {
		if(items==null || items.size()<1) {
			return SKIP_BODY;
		}
		
		pageContext.setAttribute(var, items.get(idx));
		
		return EVAL_BODY_AGAIN;
	}
	
	@Override
	public int doAfterBody() throws JspException {
		if(++idx < items.size()) {
			pageContext.setAttribute(var, items.get(idx));
			return EVAL_BODY_AGAIN;
		}
		
		return SKIP_BODY;
	}
	@Override
	public int doEndTag() throws JspException {
		idx = 0;
		items = null;	
		return EVAL_PAGE;
	}

}
