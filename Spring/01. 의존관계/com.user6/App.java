package com.user6;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class App {
	public static void main(String[] args) {
		// 스프링 컨테이너 생성 
		AbstractApplicationContext context = new GenericXmlApplicationContext("classpath:com/user6/applicationContext.xml");
		
		try {
			Movie mv1 = context.getBean(Movie.class);
			Movie mv2 = context.getBean(Movie.class);
			
			Music ms1 = context.getBean(Music.class);
			Music ms2 = context.getBean(Music.class);
			
			mv1.play();
			mv2.play();
			
			ms1.play();
			ms2.play();
			
			if(mv1==mv2) {
				System.out.println("mv1, mv2 는 동일 객체");
			} else {
				System.out.println("mv1, mv2 는 다른 객체");
			}
			
			if(ms1==ms2) {
				System.out.println("ms1, ms2 는 동일 객체");
			} else {
				System.out.println("ms1, ms2 는 다른 객체");
			}
			
		} finally {
			context.close();
		}
	}
	
}