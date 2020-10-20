package com.test1;

import org.springframework.beans.factory.annotation.Required;

public class UserServiceImpl implements UserService {

	private String name;
	private String tel;
	private int age;	
	
	public String getName() {
		return name;
	}
	
	@Required
	public void setName(String name) {
		this.name = name;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	@Override
	public String message() {
		String s = "이름:"+name+",전화번호:"+tel+",나이:"+age;
		return s;
	}

}
