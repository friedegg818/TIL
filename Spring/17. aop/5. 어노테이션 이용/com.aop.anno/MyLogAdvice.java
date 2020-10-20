package com.aop.anno;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

// @Aspect : 자동으로 Advice 적용 
@Aspect
public class MyLogAdvice {
	
	@Pointcut(value="execution(public * com.aop.anno.*.*(..))")
	private void allMethod() {
		// 가명 메소드 : private void 이고 메소드 몸체가 없어야 함 
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
		
		System.out.println("** aop returningLogging -> " + methodName + ", 리턴값 : " + ret);
	}
	
	@AfterThrowing(value="allMethod()", throwing="ex")
	public void throwingLogging(JoinPoint joinPoint, Throwable ex) {
		String methodName = joinPoint.getSignature().getName();
		
		System.out.println("** aop throwingLoggin -> " + methodName + ", 예외 클래스 : " + ex.getClass().getName());
	}
	
	@After("allMethod()")
	public void afterLogging(JoinPoint joinPoint) {
		String methodName = joinPoint.getSignature().getName();
		System.out.println("** aop afterLoggin : 예외 발생 여부와 상관 없이 실행 -> " + methodName);
	}	
}
