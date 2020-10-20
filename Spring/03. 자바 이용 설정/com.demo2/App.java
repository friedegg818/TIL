package com.demo2;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;

public class App {
	public static void main(String[] args) {
		// ������ �����̳� ���� 
		AbstractApplicationContext context = new AnnotationConfigApplicationContext(SpringConfig.class);
		
		try {
			// �����̳ʿ��� �ش� ��ü �������� 
			// UserBean bean = (UserBean)context.getBean(UserBean.class);
			UserBean bean = (UserBean)context.getBean("demo2.bean");  
			bean.write();
		} finally {
			context.close();
		}
	}
	
}