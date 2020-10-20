package com.sp.user9;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("uesr9.userController")
public class UserController {
	@RequestMapping("/user9/main")
	public String main() {
		return "user9/user";
	}
	
	@RequestMapping("/user9/request")	// 	GET/POST 모두 처리 
	public String result(
			@RequestHeader("Accept-Language") String lang,
			@RequestHeader("User-Agent") String agent,
			HttpServletRequest req,
			Model model
			) {
		
		String s = "header 정보 <br>";
		s += "클라이언트 언어 : " + lang;
		s += "<br>클라이언트 브라우저 및 os : " + agent;
		
		// referer : 이전 주소. @RequestHeader로는 확인 불가 
		String referer = req.getHeader("Referer");
		if(referer==null) {
			referer = "이전 주소 없음";
		}
		s += "<br>이전 주소: " + referer;
		
		model.addAttribute("result", s);
		
		return "user9/view";
	}
}
