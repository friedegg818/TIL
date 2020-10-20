package com.sp.user2;

import org.springframework.stereotype.Service;

@Service("user2.userService")
public interface UserService {
	public String message(int age);
}
