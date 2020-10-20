package com.demo2;

import org.springframework.beans.factory.annotation.Autowired;

public class UserBean {
	@Autowired
	private UserService userService;
	
	public void init() {
		System.out.println("init...");
	}
	
	public void write() {
		String m = userService.message();
		System.out.println(m);
	}
	
	public void destroy() {
		System.out.println("destroy...");
	}
}
