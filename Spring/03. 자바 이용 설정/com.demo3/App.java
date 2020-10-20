package com.demo3;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;

import com.demo3.config.SpringConfig;

public class App {
	public static void main(String[] args) {
		// ������ �����̳� ���� 
		AbstractApplicationContext context = new AnnotationConfigApplicationContext(SpringConfig.class);
		
		try {
			// �����̳ʿ��� �ش� ��ü �������� 
			// UserBean bean = context.getBean(UserBean.class);
			UserBean bean = context.getBean("userBean", UserBean.class);
			bean.write();
		} finally {
			context.close();
		}
	}
	
}