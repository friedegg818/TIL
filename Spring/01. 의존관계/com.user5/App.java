package com.user5;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class App {
	public static void main(String[] args) {
		// ������ �����̳� ���� 
		AbstractApplicationContext context = new GenericXmlApplicationContext("classpath:com/user5/applicationContext.xml");
		
		try {
			// �����̳ʿ��� �ش� ��ü �������� 
			UserBean bean = context.getBean(UserBean.class);
			bean.write();
			
			UserBean2 bean2 = context.getBean(UserBean2.class);
			bean2.write();
			
		} finally {
			context.close();
		}
	}
	
}