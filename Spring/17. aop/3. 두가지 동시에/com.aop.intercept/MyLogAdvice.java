package com.aop.intercept;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;

// MethodInterceptor : �޼ҵ� ���� ��, �� �Ǵ� ���� �߻� ������ ���� ����� ���� 
public class MyLogAdvice implements MethodInterceptor {

	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {
		// ��� ��ü ȣ�� �� 
		System.out.println("## AOP �޼ҵ� ȣ�� �� : " + invocation.getMethod().getName());
		
		// ��� ��ü ȣ�� 
		Object returnValue = invocation.proceed();
		
		// ��� ��ü ȣ�� �� 
		System.out.println("## AOP �޼ҵ� ȣ�� �� : " + invocation.getMethod().getName() + ", ���� �� : " + returnValue);
		
		return returnValue;
	}

}
