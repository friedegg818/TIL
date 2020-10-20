package com.test4;

import javax.annotation.Resource;

public class UserBean {
	// id를 이용한 의존관계 설정. java 어노테이션 
    @Resource(name="userService1")
	private UserService userService;

	public void write() {
		String m = userService.message();
		System.out.println(m);
	}
}
