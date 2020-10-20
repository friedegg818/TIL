package com.filter;

import java.text.NumberFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class MyPayParameter extends HttpServletRequestWrapper {
	
	public MyPayParameter(HttpServletRequest req) {		// 인자가 있는 생성자 (아버지 클래스에 있으므로 만들어 주어야 함)
		super(req);
	}

	@Override
	public String getParameter(String name) {
		if(name.equals("pay")) {
			NumberFormat nf = NumberFormat.getCurrencyInstance();
			String s = nf.format(Long.parseLong(super.getParameter(name)));
			return s;
		}
		
		return super.getParameter(name);
	}
}
