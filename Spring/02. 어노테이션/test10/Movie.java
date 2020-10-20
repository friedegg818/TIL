package com.test10;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Scope(value="prototype")
public class Movie {
	public void play() {
		System.out.println("¿µÈ­ : " + toString());
	}
}
