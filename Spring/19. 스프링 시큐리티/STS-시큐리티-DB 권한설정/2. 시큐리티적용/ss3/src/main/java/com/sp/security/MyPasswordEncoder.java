package com.sp.security;

import javax.annotation.PostConstruct;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service("security.myPasswordEncoder")
public class MyPasswordEncoder {
	private PasswordEncoder passwordEncoder;

	@PostConstruct
	public void init() {
		passwordEncoder = new BCryptPasswordEncoder();
	}
	
	public String encode(String password) {
		String encPassword = null;
		encPassword = passwordEncoder.encode(password);

		return encPassword;
	}
	
	public boolean matches(String password, String encPassword) {
		return passwordEncoder.matches(password, encPassword);
	}
}
