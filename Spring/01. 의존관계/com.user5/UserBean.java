package com.user5;

public class UserBean {
	private UserService userService;
	
	public UserBean (UserService userService) {
		this.userService = userService;
	}

	public void write() {
		String m = userService.message();
		System.out.println("�����ڷ� �ڵ� ���� -> " + m);
	}
}
