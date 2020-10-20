package com.aop.anno;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;

// @Aspect : �ڵ����� Advice ���� 
@Aspect
public class MyLogAdvice2 {
	@Before("execution(public * com.aop.anno.*.*(..))")
	public String beforeLogging(JoinPoint joinPoint) {
		String methodName = joinPoint.getSignature().getName();
		
		System.out.println("** aop beforeLogging ->" + methodName);
		
		return methodName;
	}
	
	@AfterReturning(pointcut="execution(public * com.aop.anno.*.*(..))", returning="ret")
	public void returningLogging(JoinPoint joinPoint, Object ret) {
		String methodName = joinPoint.getSignature().getName();
		
		System.out.println("** aop returningLogging -> " + methodName + ", ���ϰ� : " + ret);
	}
	
	@AfterThrowing(pointcut="execution(public * com.aop.anno.*.*(..))", throwing="ex")
	public void throwingLogging(JoinPoint joinPoint, Throwable ex) {
		String methodName = joinPoint.getSignature().getName();
		
		System.out.println("** aop throwingLoggin -> " + methodName + ", ���� Ŭ���� : " + ex.getClass().getName());
	}
	
	@After("execution(public * com.aop.anno.*.*(..))")
	public void afterLogging(JoinPoint joinPoint) {
		String methodName = joinPoint.getSignature().getName();
		System.out.println("** aop afterLoggin : ���� �߻� ���ο� ��� ���� ���� -> " + methodName);
	}	
}
