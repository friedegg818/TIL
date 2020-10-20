package com.sp.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

// 로그인 성공 후에 할 작업을 처리하는 클래스 
public class MyAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

		@Autowired
		private MemberService service;
		
		@Override
		public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
				Authentication authentication) throws ServletException, IOException {		// Authentication : 로그인 한 사용자의 정보를 가지고 있음 
			
			//로그인 날짜 변경 
			String userId = authentication.getName();
			try {
				service.updateLastLogin(userId);
			} catch (Exception e) {
			}
			
			// 로그인 세션 정보에 저장 
			Member dto = service.readMember(userId);
			SessionInfo info = new SessionInfo();
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());
			
			HttpSession session = request.getSession();
			session.setAttribute("member", info);
		
			
			super.onAuthenticationSuccess(request, response, authentication);
		}	  

}
