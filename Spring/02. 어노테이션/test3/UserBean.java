package com.test3;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

public class UserBean {
	// @Qualifier : @Autowired 와 같이 사용하며, 동일한 타입이 둘 이상 일 때 id로 의존 관계를 설정한다.	
	@Autowired
	@Qualifier("userService2")
	private UserService userService;

	public void write() {
		String m = userService.message();
		System.out.println(m);
	}
}
