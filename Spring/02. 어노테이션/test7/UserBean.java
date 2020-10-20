package com.test7;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

// 객체 생성. id는 자동으로 첫글자가 소문자인 클래스명이 부여 된다.
// 아이디 : userBean 
@Component
public class UserBean {
	@Autowired
	private UserService userService;

	public void write() {
		String m = userService.message();
		System.out.println(m);
	}
}
