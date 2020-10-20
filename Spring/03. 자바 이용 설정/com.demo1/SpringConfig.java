package com.demo1;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

// 환경 설정
@Configuration
public class SpringConfig {
	// 객체를 생성해서 컨테이너에 담아 놓음 
	// 객체를 여러번 불러도 한 번만 생성 됨 
	@Bean	
	public UserBean beanDevice() {
		return new UserBean();
	}
	
	@Bean
	public UserService userServiceDevice() {
		return new UserServiceImpl();
	}
}
