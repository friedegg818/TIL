package com.sp.user2;

import org.springframework.stereotype.Service;

@Service("user2.userService")
public class UserServiceImpl implements UserService {

	@Override
	public String message(int age) {
		return age>=19 ? "성인" : "미성년자";
	}
}
