package com.test8;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

// 아이디를 지정
@Component("test8.userBean")
public class UserBean {
	@Autowired
	private UserService userService;

	public void write() {
		String m = userService.message();
		System.out.println(m);
	}
}
