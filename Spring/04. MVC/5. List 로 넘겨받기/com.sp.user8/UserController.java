package com.sp.user8;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("user8.userController")
@RequestMapping("/user8/*")
public class UserController {
	@GetMapping("request")
	public String form() {
		return "user8/write";
	}
	
/*	
	- 파라미터의 이름이 동일한 경우 List 로 파라미터 넘겨 받기 
	  - @RequestParam 어노테이션이 필요 	 
*/
	
	@PostMapping("request")
	public String submit(
			String name, int age, 
			@RequestParam(required=false) List<String> hobby,
			Model model) {
		
		String s; 
		
		s = "이름 : " + name + "<br>";
		s += "나이 : " + age + "<br>";	
		s += "취미 : ";
		
		if(hobby!=null) {
			for(String h : hobby) {
				s += h + " ";
			}
		}
		
		model.addAttribute("result", s);
		
		return "user8/view";
	}
}
