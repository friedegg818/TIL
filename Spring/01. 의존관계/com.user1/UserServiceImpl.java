package com.user1;

public class UserServiceImpl implements UserService {

	private String name;
	private String tel;
	private int age;
	
	public UserServiceImpl() {
		name = "스프링";
		tel = "010-1111-1111";
		age = 20;
	}
	
	@Override
	public String message() {
		String s = "이름:"+name+",전화번호:"+tel+",나이:"+age;
		return s;
	}

}
