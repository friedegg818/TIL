package com.user2;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class App {
	public static void main(String[] args) {
		// 스프링 컨테이너 생성 
		AbstractApplicationContext context = new GenericXmlApplicationContext("classpath:com/user2/applicationContext.xml");
		
		try {
			// 컨테이너에서 해당 객체 가져오기 
			UserBean bean = (UserBean)context.getBean("userBean");
			bean.write();
		} finally {
			context.close();
		}
	}
}