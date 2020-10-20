package com.aop.before;

import java.lang.reflect.Method;

import org.springframework.aop.MethodBeforeAdvice;

// MethodBeforeAdvice : 대상객체의 메소드를 실행 하기 전에 공통 기능을 실행 할 때 사용하는 Advice
public class BeforeLogAdvice implements MethodBeforeAdvice {
	@Override
	public void before(Method method, Object[] args, Object target) throws Throwable {
		String s="-------------------------------\n";
		s += method.toString()+ " 메소드 : " + target + " 에서 호출 전 실행...";
		if(args!=null) {
			s += "\n 매개변수 : ";
			for(int i=0; i<args.length; i++) {
				s += args[i]+" ";
			}
		}
		s+="\n-------------------------------";
		
		System.out.println(s);		
	}

}
