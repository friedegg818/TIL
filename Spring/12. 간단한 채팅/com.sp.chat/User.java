package com.sp.chat;

import org.springframework.web.socket.WebSocketSession;

public class User {
	private String userId;
	private String nickName;
	private WebSocketSession session;		// 클라이언트를 나타내는 객체 (=자바의 socket)\
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public WebSocketSession getSession() {
		return session;
	}
	public void setSession(WebSocketSession session) {
		this.session = session;
	}	
}
