package com.aop.anno;

public class UserServiceImpl implements UserService {

	@Override
	public int evenSum(int n) {
		System.out.println("짝수 합 계산 >>>");
		
		int s = 0;
		
		for(int i=2; i<=n; i+=2) {
			s += i;
		}
		return s;
	}

	@Override
	public void write(int s) {
		System.out.println("결과 : " + s);		
	}

}
