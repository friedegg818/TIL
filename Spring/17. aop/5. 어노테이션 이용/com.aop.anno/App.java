package com.aop.anno;

import org.springframework.context.support.GenericXmlApplicationContext;

public class App {
	public static void main(String[] args) {
		GenericXmlApplicationContext context = new GenericXmlApplicationContext("classpath:com/aop/anno/applicationContext.xml");
		
		try {
			UserService service = (UserService) context.getBean("userService");
			int s = service.evenSum(100);			
			service.write(s);
		} finally {
			context.close();
		}
	}
}
