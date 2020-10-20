package com.sp.user;

import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

	@Override
	public String message(User dto) {
		String s = dto.getName() + "님은 " + (dto.getAge() >= 19 ? "성인 입니다." : "미성년자 입니다.");
 		return s;
	}	
}
