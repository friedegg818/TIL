package com.sp.chat;

import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.annotation.PostConstruct;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.core.JsonGenerationException;



public class MySocketHandler extends TextWebSocketHandler {
	private final Logger logger = LoggerFactory.getLogger(MySocketHandler.class);
	
	private Map<String, User> sessionMap = new Hashtable<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// super.afterConnectionEstablished(session);
		// WebSocket 연결되고 사용 준비가 될 때 
	}	

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {		
		super.handleMessage(session, message);
		
		// 클라이언트로부터 메시지를 전달 받은 경우 
		JSONObject jsonReceive = null;
		
		try {
			jsonReceive = new JSONObject(message.getPayload().toString());		// Payload : 실질적인 메세지
		} catch (Exception e) {
		}
		
		if(jsonReceive==null) {
			return;
		}
		
		String cmd = jsonReceive.getString("cmd");
		if(cmd==null) {
			return;
		}
		
		if(cmd.equals("connect")) { // 처음 접속한 경우 
			// 처음 접속 사용자를 sessionMap에 저장 
			String userId = jsonReceive.getString("userId");
			String nickName = jsonReceive.getString("nickName");
			
			User user = new User();
			user.setUserId(userId);
			user.setNickName(nickName);
			user.setSession(session);
			
			sessionMap.put(userId, user);
			
			// 현재 접속한 사용자를 전송 
			Iterator<String> it = sessionMap.keySet().iterator();
			while(it.hasNext()) {
				String key = it.next();
				if(userId.equals(key)) {
					continue;
				}
				
				User vo = sessionMap.get(key);
				
				JSONObject ob = new JSONObject();
				ob.put("cmd", "connectList");
				ob.put("userId", vo.getUserId());
				ob.put("nickName", vo.getNickName());
				
				sendOneMessage(ob.toString(), session);				
			}
			
			// 다른 클라이언트에게 접속 사실 알림 
			JSONObject ob = new JSONObject();
			ob.put("cmd", "connect");
			ob.put("userId", userId);
			ob.put("nickName", nickName);
			sendAllMessage(ob.toString(), userId);
			
		} else if(cmd.equals("message")) {	// 채팅 문자열을 받은 경우 
			User user = getUser(session);
			String msg = jsonReceive.getString("chatMsg");
			
			JSONObject job = new JSONObject();
			job.put("cmd", "message");
			job.put("chatMsg", msg);
			job.put("user", user.getUserId());
			job.put("nickName", user.getNickName());
			
			sendAllMessage(job.toString(), user.getUserId());	// 자기 자신은 제외 
		}
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		// super.handleTransportError(session, exception);
		removeUser(session);		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {	
		super.afterConnectionClosed(session, status);
		
		// websocket 연결이 닫혔을때 호출 (클라이언트가 도망갔을때)
		removeUser(session);
		
		logger.info("remove session...");
	}
	
	
	/**	 
	 * @param msg 전송할 메세지
	 * @param out 전송에서 제외 할 유저
	 */
	// 모든 사용자에게 메세지 전송 
	protected void sendAllMessage(String msg, String out) {
		Iterator<String> it = sessionMap.keySet().iterator();
		
		while(it.hasNext()) {
			String key = it.next();
			if(out!=null && out.equals(key)) {
				// 자기 자신
				continue;
			}
			
			User user = sessionMap.get(key);
			WebSocketSession session = user.getSession();
			
			try {
				if(session.isOpen()) {
					session.sendMessage(new TextMessage(msg));
				}
			} catch (Exception e) {
				removeUser(session);
			}
		}
	}
	
	// 특정 사용자에게만 메세지 전송 
	protected void sendOneMessage(String msg, WebSocketSession session) {
		if(session.isOpen()) {			// 세션이 살아있으면
			try {
				session.sendMessage(new TextMessage(msg));
			} catch (Exception e) {
				logger.error("fail to send message..." + e.toString());
			}
		}
	}
	
	// session에 해당하는 User 객체 반환 
	protected User getUser(WebSocketSession session) { 
		User dto = null;
		
		Iterator<String> it = sessionMap.keySet().iterator();
		while(it.hasNext()) {
			String id = it.next();
			User user = sessionMap.get(id);
			if(user.getSession() == session) {
				dto = user;
				break;
			}
		}		
		return dto;
	}
	
	// sessionMap에서 유저 제거 
	protected void removeUser(WebSocketSession session) {
		User user = getUser(session);
		
		if(user!=null) {
			// 접속 해제 사실을 모든 사용자에게 전송 
			JSONObject job = new JSONObject();
			job.put("cmd", "disconnect");
			job.put("userId", user.getUserId());
			job.put("nickName", user.getNickName());
			sendAllMessage(job.toString(), user.getUserId());
			
			try {
				user.getSession().close();
			} catch (Exception e) {
			}
			sessionMap.remove(user.getUserId());			
		}
	}
	
	@PostConstruct 	// 생성자가 실행되고 난 후 작동
	public void init() throws Exception {		// 일정 시간이 지나도 접속이 유지되도록 주기적으로 시간을 쏴줌 
		TimerTask task = new TimerTask() {			
			@Override
			public void run() {
				Calendar cal = Calendar.getInstance();
				int h = cal.get(Calendar.HOUR_OF_DAY);	// HOUR_OF_DAY : 12시 > 12시 
				int m = cal.get(Calendar.MINUTE);
				int s = cal.get(Calendar.SECOND);
				
				JSONObject job = new JSONObject();
				job.put("cmd", "time");
				job.put("hour", h);
				job.put("minute", m);
				job.put("second", s);
				
				sendAllMessage(job.toString(), null);	// 모두에게 보냄 
			}
		};
		
		Timer timer = new Timer();
		timer.schedule(task, new Date(System.currentTimeMillis()+1000*60*3), 1000*60*3);	// 접속하고 3분 후부터 3분마다
	}
	
	
}
