package com.user7;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class App {
	public static void main(String[] args) {
		// ������ �����̳� ���� 
		AbstractApplicationContext context = new GenericXmlApplicationContext("classpath:com/user7/applicationContext.xml");
		
		try {
			// prototype : ��ü�� �����̳ʿ��� ȣ�� �� ������ ���ο� ��ü ���� 
			Movie mv1 = context.getBean(Movie.class);	// prototype
			Movie mv2 = context.getBean(Movie.class);
			
			Music ms1 = context.getBean(Music.class);	// prototype
			Music ms2 = context.getBean(Music.class);
			
			System.out.println(mv1+", "+mv2);	// �ٸ� ��ü
			System.out.println(ms1+", "+ms2);	// �ٸ� ��ü 
			
			System.out.println("-------------------------------");
			
			Movie mv = context.getBean(Movie.class);
			Music ms = context.getBean(Music.class);
			
			// ��ü�� �ѹ��� �����ϰ� �޼ҵ常 ������ ȣ�� �� �� 
			mv.play();
			mv.play();	// ���� ��ü
			
			ms.play();
			ms.play();	// �ٸ� ��ü 
			
			System.out.println("-------------------------------");
			
			UserBean bean = context.getBean(UserBean.class);			
			bean.execute();
			bean.execute();
			bean.execute();
			
			System.out.println("-------------------------------");
			
		} finally {
			context.close();
		}
	}
	
}