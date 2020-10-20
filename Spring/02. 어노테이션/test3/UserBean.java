package com.test3;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

public class UserBean {
	// @Qualifier : @Autowired �� ���� ����ϸ�, ������ Ÿ���� �� �̻� �� �� id�� ���� ���踦 �����Ѵ�.	
	@Autowired
	@Qualifier("userService2")
	private UserService userService;

	public void write() {
		String m = userService.message();
		System.out.println(m);
	}
}
