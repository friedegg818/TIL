package com.test2;

import org.springframework.beans.factory.annotation.Autowired;

public class UserBean {
	// �������踦 Ÿ������ �ڵ� ����. setter�� �ʿ� ����. (������ ����)
	// ��, ������ Ÿ���� ��ü�� �� �� �̻� �����ϸ� �ʵ��� ������ id�� ã��, ������ ���� 
	@Autowired
	private UserService userService;

	public void write() {
		String m = userService.message();
		System.out.println(m);
	}
}
