package com.aop.after;

public class UserServiceImpl implements UserService {
	private String value;
	
	@Override
	public void setData(String value) {
		System.out.println("setData �޼ҵ� ȣ��...");
		this.value = value;		
	}

	@Override
	public void write() {
	 /* System.out.println(Integer.parseInt("aa")); ���ܰ� �ִ� ��쿡�� ������ �� �� */ 
		System.out.println("��� : " + value);		
	}
}
