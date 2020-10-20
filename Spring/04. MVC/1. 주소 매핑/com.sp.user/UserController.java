package com.sp.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

// 컨트롤러 역할을 하는 클래스에 표기. 객체 자동 생성 
@Controller
@RequestMapping("/user/*")		// <%=cp%> 이후 주소가 user 로 시작하는 모든 것을 처리 
public class UserController {
	@Autowired
	private UserService userService; 
	
	@GetMapping("request")	// get 방식
	public String form() {
		return "user/write";
	}
	
	@PostMapping("request")	// post 방식 
	public String submit(User dto, Model model) {		// Model : jsp 에 넘길 data를 담고 있음 
		String s = userService.message(dto);
		
		model.addAttribute("dto", dto);
		model.addAttribute("data",s);
		
		return "user/result";
	}
}
