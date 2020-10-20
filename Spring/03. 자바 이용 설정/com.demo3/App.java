package com.demo3;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;

import com.demo3.config.SpringConfig;

public class App {
	public static void main(String[] args) {
		// 스프링 컨테이너 생성 
		AbstractApplicationContext context = new AnnotationConfigApplicationContext(SpringConfig.class);
		
		try {
			// 컨테이너에서 해당 객체 가져오기 
			// UserBean bean = context.getBean(UserBean.class);
			UserBean bean = context.getBean("userBean", UserBean.class);
			bean.write();
		} finally {
			context.close();
		}
	}
	
}