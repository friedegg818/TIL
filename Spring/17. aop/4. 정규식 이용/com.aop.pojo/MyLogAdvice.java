package com.aop.pojo;

import org.aspectj.lang.JoinPoint;

public class MyLogAdvice {
	public String beforeLogging(JoinPoint joinPoint) {
		String methodName = joinPoint.getSignature().getName();
		
		System.out.println("** aop beforeLogging ->" + methodName);
		
		return methodName;
	}
	
	public void returningLogging(JoinPoint joinPoint, Object ret) {
		String methodName = joinPoint.getSignature().getName();
		
		System.out.println("** aop returningLogging -> " + methodName + ", 리턴값 : " + ret);
	}
	
	public void throwingLogging(JoinPoint joinPoint, Throwable ex) {
		String methodName = joinPoint.getSignature().getName();
		
		System.out.println("** aop throwingLoggin -> " + methodName + ", 예외 클래스 : " + ex.getClass().getName());
	}
	
	public void afterLogging(JoinPoint joinPoint) {
		String methodName = joinPoint.getSignature().getName();
		System.out.println("** aop afterLoggin : 예외 발생 여부와 상관 없이 실행 -> " + methodName);
	}	
}
