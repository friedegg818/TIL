package com.user9;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class App {
	public static void main(String[] args) {
		// ������ �����̳� ���� 
		AbstractApplicationContext context = new GenericXmlApplicationContext("classpath:com/user9/applicationContext.xml");
		
		try {
			// �����̳ʿ��� �ش� ��ü �������� 
			UserBean bean = (UserBean)context.getBean(UserBean.class);
			bean.write();
		} finally {
			context.close();
		}
	}
	
}