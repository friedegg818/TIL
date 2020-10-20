package com.user1;

public class UserBean {
	private UserService userService;	
	
	public UserBean(UserService userService) {
		this.userService = userService;
	}
	
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
