package com.test5;

import javax.inject.Inject;

public class UserBean {
	// 타입으로 의존관계 자동 설정. java 지원 
    @Inject
	private UserService userService;

	public void write() {
		String m = userService.message();
		System.out.println(m);
	}
}
