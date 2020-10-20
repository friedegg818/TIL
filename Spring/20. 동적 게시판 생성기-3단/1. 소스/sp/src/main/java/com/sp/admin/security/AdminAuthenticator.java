package com.sp.admin.security;

import javax.servlet.http.HttpSession;

import com.sp.member.SessionInfo;

// 어텐더케이터 클래스
public class AdminAuthenticator {
	public static boolean isAuthenticator(HttpSession session) throws LoginValidException, AuthorizedValidException {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info.getMembership()<90) {
			throw new AuthorizedValidException("접근 권한이 필요 합니다.");
		}
		
		return true;
	}
}
