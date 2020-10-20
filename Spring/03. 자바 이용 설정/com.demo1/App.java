package com.demo1;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class App {
	public static void main(String[] args) {
		// 스프링 컨테이너 생성 
		AbstractApplicationContext context = new GenericXmlApplicationContext("classpath:com/demo1/applicationContext.xml");
		
		try {
			// 컨테이너에서 해당 객체 가져오기 
			// UserBean bean = (UserBean)context.getBean(UserBean.class);
			UserBean bean = (UserBean)context.getBean("beanDevice");     // id : 메소드 명 
			bean.write();
		} finally {
			context.close();
		}
	}
	
}