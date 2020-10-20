package com.aop.intercept;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;

// MethodInterceptor : 메소드 실행 전, 후 또는 예외 발생 시점에 공통 기능을 실행 
public class MyLogAdvice implements MethodInterceptor {

	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {
		// 대상 객체 호출 전 
		System.out.println("## AOP 메소드 호출 전 : " + invocation.getMethod().getName());
		
		// 대상 객체 호출 
		Object returnValue = invocation.proceed();
		
		// 대상 객체 호출 후 
		System.out.println("## AOP 메소드 호출 후 : " + invocation.getMethod().getName() + ", 리턴 값 : " + returnValue);
		
		return returnValue;
	}

}
