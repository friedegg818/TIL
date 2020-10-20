package com.aop.pojo;

import java.lang.reflect.Method;

import org.springframework.aop.AfterReturningAdvice;

// AfterReturningAdvice : 대상 객체의 메소드를 실행 이후에 공통 기능을 실행 할 때 사용 
// 					            예외없이 실행 되는 경우에만 실행 
public class AfterLogAdvice implements AfterReturningAdvice {

	@Override
	public void afterReturning(Object returnValue, Method method, Object[] args, Object target) throws Throwable {
		System.out.println("## after aop 시작 ---------------------------");
		
		String s = method.toString() + " 메소드 : " + target + "에서  호출 후..";
		s += "\n 리턴 값 : " + returnValue;
		System.out.println("aop 결과 : " + s);
		
		System.out.println("## after aop 종료 ---------------------------");
	}

}
