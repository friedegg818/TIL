package com.sp.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

public class LoginFailureHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	private static final Logger logger = LoggerFactory.getLogger(LoginFailureHandler.class);

	@Override
	public void onAuthenticationSuccess(HttpServletRequest req,
			HttpServletResponse resp, Authentication authentication)
			throws ServletException, IOException {
		HttpSession session=req.getSession();
		
		logger.debug("로그인에 실패하였습니다.");

        int cnt=0;
        if(session!=null){
            Object o=session.getAttribute("badCredentialsCnt");
            if(o!=null)cnt=(Integer)o;
        }
         
        session.setAttribute("badCredentialsCnt", ++cnt);
        logger.debug("{}회 로그인에 실패하였습니다.", cnt);

        // 3회 실패시
        if(cnt>=3){
            // DB 처리
        }
        
        // 접속 로그인 실패시
        resp.sendRedirect(req.getContextPath()+"/member/login?login_error");
	}
}
