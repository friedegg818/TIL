package com.user3;

public class UserServiceImpl implements UserService {

	private String name;
	private String tel;
	private int age;
	
	public UserServiceImpl() {	
	}
	
	public UserServiceImpl(String name, String tel, int age) {
		this.name = name;
		this.tel = tel;
		this.age = age;
	}	
	
	public String getName() {
		return name;
	}

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
