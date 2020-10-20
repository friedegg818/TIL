package com.sp.sbbs;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.member.LoginService;
import com.sp.member.SessionInfo;

@Controller("sbbs.boardController")
public class BoardController {
	@Autowired
	private LoginService loginService;
	
	@RequestMapping("/sbbs/list")
	public String list() throws Exception {
		SessionInfo info = loginService.loginMemberInfo();
		
		if(info==null) {
			return "redirect:/login";
		}		
		return "sbbs/list";
	}
}
