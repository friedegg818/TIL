package com.user3;

public class UserBean {
	private UserService userService;
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public void write() {
		String m = userService.message();
		System.out.println(m);
	}
}
