package com.test2;

import org.springframework.beans.factory.annotation.Autowired;

public class UserBean {
	// 의존관계를 타입으로 자동 설정. setter가 필요 없음. (스프링 제공)
	// 단, 동일한 타입의 객체가 두 개 이상 존재하면 필드명과 동일한 id를 찾고, 없으면 예외 
	@Autowired
	private UserService userService;

	public void write() {
		String m = userService.message();
		System.out.println(m);
	}
}
