package com.demo2;

public class UserServiceImpl implements UserService {
	private String name;
	private String tel;
	private int age;
	
	@Override
	public String message() {
		return name+", "+tel+", "+age+", "+(age>=19? "성인" : "미성년자");
	}	
	
	public UserServiceImpl() {
		name = "홍자바";
		tel = "010";
		age = 20;
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

}
