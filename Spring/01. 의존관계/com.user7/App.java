package com.user7;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class App {
	public static void main(String[] args) {
		// 스프링 컨테이너 생성 
		AbstractApplicationContext context = new GenericXmlApplicationContext("classpath:com/user7/applicationContext.xml");
		
		try {
			// prototype : 객체를 컨테이너에서 호출 할 때마다 새로운 객체 생성 
			Movie mv1 = context.getBean(Movie.class);	// prototype
			Movie mv2 = context.getBean(Movie.class);
			
			Music ms1 = context.getBean(Music.class);	// prototype
			Music ms2 = context.getBean(Music.class);
			
			System.out.println(mv1+", "+mv2);	// 다른 객체
			System.out.println(ms1+", "+ms2);	// 다른 객체 
			
			System.out.println("-------------------------------");
			
			Movie mv = context.getBean(Movie.class);
			Music ms = context.getBean(Music.class);
			
			// 객체는 한번만 생성하고 메소드만 여러번 호출 한 것 
			mv.play();
			mv.play();	// 같은 객체
			
			ms.play();
			ms.play();	// 다른 객체 
			
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