package com.demo1;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

// ȯ�� ����
@Configuration
public class SpringConfig {
	// ��ü�� �����ؼ� �����̳ʿ� ��� ���� 
	// ��ü�� ������ �ҷ��� �� ���� ���� �� 
	@Bean	
	public UserBean beanDevice() {
		return new UserBean();
	}
	
	@Bean
	public UserService userServiceDevice() {
		return new UserServiceImpl();
	}
}
