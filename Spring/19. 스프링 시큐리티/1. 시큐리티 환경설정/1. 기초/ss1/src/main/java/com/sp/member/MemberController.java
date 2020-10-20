package com.sp.member;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

// security

@Controller("member.memberController")
public class MemberController {
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login() {
		
		return "member/login";
	}
	
	// 접근 오서라이제이션(Authorization:권한)이 없는 경우
	@RequestMapping(value="/noAuthorized")
	public String noAuthorized() {
		
		return "member/noAuthorized";
	}
	
}
