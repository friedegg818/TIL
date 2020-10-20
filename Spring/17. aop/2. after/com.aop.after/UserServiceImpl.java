package com.aop.after;

public class UserServiceImpl implements UserService {
	private String value;
	
	@Override
	public void setData(String value) {
		System.out.println("setData 메소드 호출...");
		this.value = value;		
	}

	@Override
	public void write() {
	 /* System.out.println(Integer.parseInt("aa")); 예외가 있는 경우에는 실행이 안 됨 */ 
		System.out.println("결과 : " + value);		
	}
}
