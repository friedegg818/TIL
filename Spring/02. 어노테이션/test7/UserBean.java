package com.test7;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

// ��ü ����. id�� �ڵ����� ù���ڰ� �ҹ����� Ŭ�������� �ο� �ȴ�.
// ���̵� : userBean 
@Component
public class UserBean {
	@Autowired
	private UserService userService;

	public void write() {
		String m = userService.message();
		System.out.println(m);
	}
}
