package com.user8;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class App {
	public static void main(String[] args) {
		// 스프링 컨테이너 생성 
		AbstractApplicationContext context = new GenericXmlApplicationContext("classpath:com/user8/applicationContext.xml");
		
		try {
			PizzaShop shop = context.getBean(PizzaShop.class);
			
			Pizza p1 = shop.makePizza();
			System.out.println("처음 : " + p1);
			
			Pizza p2 = shop.makePizza();
			System.out.println("두번째 : " + p2);
			
			Pizza p3 = shop.makeVeggiePizza();
			System.out.println("Veggie : " + p3);
			
		} finally {
			context.close();
		}
	}
	
}