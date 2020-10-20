package com.test6;

import org.springframework.beans.factory.annotation.Autowired;

public class UserBean {
	@Autowired
	private UserService userService;

	public void write() {
		String m = userService.message();
		System.out.println(m);
	}
}
