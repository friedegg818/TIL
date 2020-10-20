package com.aop.before;

import java.lang.reflect.Method;

import org.springframework.aop.MethodBeforeAdvice;

// MethodBeforeAdvice : ���ü�� �޼ҵ带 ���� �ϱ� ���� ���� ����� ���� �� �� ����ϴ� Advice
public class BeforeLogAdvice implements MethodBeforeAdvice {
	@Override
	public void before(Method method, Object[] args, Object target) throws Throwable {
		String s="-------------------------------\n";
		s += method.toString()+ " �޼ҵ� : " + target + " ���� ȣ�� �� ����...";
		if(args!=null) {
			s += "\n �Ű����� : ";
			for(int i=0; i<args.length; i++) {
				s += args[i]+" ";
			}
		}
		s+="\n-------------------------------";
		
		System.out.println(s);		
	}

}
