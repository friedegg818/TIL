package com.sp.test2;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("test2.userController")
public class UserController {
	
	@RequestMapping("/test2/main")
	public String main() {
		return "test2/main";
	}
	
	@RequestMapping("/test2/request")
	public String view(String age, Model model) {
		
		try {
			int n = Integer.parseInt(age);
			String s = "성인";
			if(n<19) {
				s = "미성년자";
			}
			model.addAttribute("result", s);
		} catch (Exception e) {
			return "redirect:/test2/error"; // 리다이렉트 	(Model값은 안 넘어감)	
		}
		
		return "test2/view";
	}
	
	@RequestMapping("/test2/error")
	public String error() {
		return "test2/error";
	}
}
