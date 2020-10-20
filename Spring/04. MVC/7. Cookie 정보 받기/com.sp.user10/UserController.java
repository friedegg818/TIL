package com.sp.user10;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("user10.userController")
public class UserController {
	@RequestMapping(value="/user10/main")
	public String main(HttpServletResponse resp) {
		// 쿠키 설정 
		Cookie c = new Cookie("subject", "spring");
		resp.addCookie(c);
		
		return "user10/main";
	}
	
	// @CookieValue : 기본값은 필수  
	@RequestMapping(value="/user10/request")
	public String result(
			@CookieValue(value="subject", required=false) String s, 
			Model model) {
		
		model.addAttribute("result", s);
		
		return "user10/view";
	}

}
