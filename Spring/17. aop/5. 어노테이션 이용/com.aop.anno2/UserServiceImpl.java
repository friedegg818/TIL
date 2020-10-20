package com.aop.anno2;

public class UserServiceImpl implements UserService {

	@Override
	public int sum(int n) {
		System.out.println("재귀호출을 이용한 합 구하기");
		
		return n>1 ? n+sum(n-1) : n;
	}

	@Override
	public void write(int s) {
		System.out.println("결과 : " + s);		
	}

}
