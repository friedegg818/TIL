package com.aop.anno2;

public class UserServiceImpl implements UserService {

	@Override
	public int sum(int n) {
		System.out.println("���ȣ���� �̿��� �� ���ϱ�");
		
		return n>1 ? n+sum(n-1) : n;
	}

	@Override
	public void write(int s) {
		System.out.println("��� : " + s);		
	}

}
