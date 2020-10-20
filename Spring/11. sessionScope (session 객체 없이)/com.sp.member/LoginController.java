package com.sp.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("member.loginController")
public class LoginController {
	@Autowired
	private LoginService service;
	
	@RequestMapping(value="/login", method=RequestMethod.GET) 
	public String loginForm() throws Exception {
		return "member/login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String loginSubmit(
			@RequestParam String userId,
			@RequestParam String userPwd
			) throws Exception {
		
		boolean b = service.requestLogin(userId, userPwd);
		if(b) {
			return "redirect:/main";
		}				
		return "member/login";
	}
	
	@RequestMapping(value="/logout") 
	public String logout(HttpSession session) throws Exception {
		session.invalidate();		
		return "redirect:/main";
	}
}
