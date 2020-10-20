package com.user5;

public class UserBean2 {
	private UserService userService;
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	public void write() {
		String m = userService.message();
		System.out.println("프로퍼티로 자동설정 -> " + m);
	}
}
