package com.test4;

import javax.annotation.Resource;

public class UserBean {
	// id�� �̿��� �������� ����. java ������̼� 
    @Resource(name="userService1")
	private UserService userService;

	public void write() {
		String m = userService.message();
		System.out.println(m);
	}
}
