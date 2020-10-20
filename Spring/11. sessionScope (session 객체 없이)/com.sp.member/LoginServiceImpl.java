package com.sp.member;

import javax.inject.Inject;
import javax.inject.Provider;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service("member.loginService")
public class LoginServiceImpl implements LoginService {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	
	@Inject	 // 자바에서 지원. 타입으로  의존관계 설정
	private Provider<SessionInfo> provider;
		// Provider : prototype bean 참조 
	
	@Override
	public SessionInfo loginMemberInfo() {
		SessionInfo info = null;
		try {
			info = provider.get();
			if(info.getUserId()==null) {
				return null;
			}
		} catch (Exception e) {
			logger.error(e.toString());
		}
		return info;
	}

	@Override
	public boolean requestLogin(String userId, String userPwd) {
		try {
			
			if(userId.equals("spring") && userPwd.equals("spring")) {
				SessionInfo info = provider.get();
				info.setUserId(userId);
				info.setUserName("자바다");
				return true;
			}
			
		} catch (Exception e) {
			logger.error(e.toString());
		}
		
		return false;
	}
	
}
