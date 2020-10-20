package com.aop.anno2;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
public class MyLogAdvice {
	@Around("execution(public * com.aop.anno2.*.*(..))")
	public Object around(ProceedingJoinPoint pjp) throws Throwable {
		// �޼ҵ� ���� �� 
		System.out.println(pjp.getSignature().getName()+" ���� ��...");
		
		// �޼ҵ� ���� 
		Object obj = pjp.proceed();
		
		// �޼ҵ� ���� �� 
		System.out.println(pjp.getSignature().getName()+" ���� ��...");
		
		return obj;
	}
}
