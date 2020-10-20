package com.aop.anno2;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
public class MyLogAdvice {
	@Around("execution(public * com.aop.anno2.*.*(..))")
	public Object around(ProceedingJoinPoint pjp) throws Throwable {
		// 메소드 실행 전 
		System.out.println(pjp.getSignature().getName()+" 실행 전...");
		
		// 메소드 실행 
		Object obj = pjp.proceed();
		
		// 메소드 실행 후 
		System.out.println(pjp.getSignature().getName()+" 실행 후...");
		
		return obj;
	}
}
