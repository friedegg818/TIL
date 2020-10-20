package com.sp.admin.security;

public class AuthorizedValidException extends Exception {
	private static final long serialVersionUID = 1L;
	
	public AuthorizedValidException(String message) {
		super(message);
	}
}
