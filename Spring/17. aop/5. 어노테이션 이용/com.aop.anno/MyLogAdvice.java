package com.aop.anno;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

// @Aspect : �ڵ����� Advice ���� 
@Aspect
public class MyLogAdvice {
	
	@Pointcut(value="execution(public * com.aop.anno.*.*(..))")
	private void allMethod() {
		// ���� �޼ҵ� : private void �̰� �޼ҵ� ��ü�� ����� �� 
	}
	
	@Before("allMethod()")
	public String beforeLogging(JoinPoint joinPoint) {
		String methodName = joinPoint.getSignature().getName();
		
		System.out.println("** aop beforeLogging ->" + methodName);
		
		return methodName;
	}
	
	@AfterReturning(value="allMethod()", returning="ret")
	public void returningLogging(JoinPoint joinPoint, Object ret) {
		String methodName = joinPoint.getSignature().getName();
		
		System.out.println("** aop returningLogging -> " + methodName + ", ���ϰ� : " + ret);
	}
	
	@AfterThrowing(value="allMethod()", throwing="ex")
	public void throwingLogging(JoinPoint joinPoint, Throwable ex) {
		String methodName = joinPoint.getSignature().getName();
		
		System.out.println("** aop throwingLoggin -> " + methodName + ", ���� Ŭ���� : " + ex.getClass().getName());
	}
	
	@After("allMethod()")
	public void afterLogging(JoinPoint joinPoint) {
		String methodName = joinPoint.getSignature().getName();
		System.out.println("** aop afterLoggin : ���� �߻� ���ο� ��� ���� ���� -> " + methodName);
	}	
}
