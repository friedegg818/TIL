package com.aop.before;

import org.springframework.context.support.GenericXmlApplicationContext;

public class App {
	public static void main(String[] args) {
		GenericXmlApplicationContext context = new GenericXmlApplicationContext("classpath:com/aop/before/applicationContext.xml");
		
		try {
			UserService service = (UserService) context.getBean("userService");
			service.setValue("AOP ¿¹Á¦");
			service.write();
		} finally {
			context.close();
		}
	}
}
