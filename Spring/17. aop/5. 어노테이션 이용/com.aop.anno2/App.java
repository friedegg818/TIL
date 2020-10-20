package com.aop.anno2;

import org.springframework.context.support.GenericXmlApplicationContext;

public class App {
	public static void main(String[] args) {
		GenericXmlApplicationContext context = new GenericXmlApplicationContext("classpath:com/aop/anno2/applicationContext.xml");
		
		try {
			UserService service = (UserService) context.getBean("userService");
			int s = service.sum(5);			
			service.write(s);
		} finally {
			context.close();
		}
	}
}
