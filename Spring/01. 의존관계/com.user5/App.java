package com.user5;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class App {
	public static void main(String[] args) {
		// 스프링 컨테이너 생성 
		AbstractApplicationContext context = new GenericXmlApplicationContext("classpath:com/user5/applicationContext.xml");
		
		try {
			// 컨테이너에서 해당 객체 가져오기 
			UserBean bean = context.getBean(UserBean.class);
			bean.write();
			
			UserBean2 bean2 = context.getBean(UserBean2.class);
			bean2.write();
			
		} finally {
			context.close();
		}
	}
	
}