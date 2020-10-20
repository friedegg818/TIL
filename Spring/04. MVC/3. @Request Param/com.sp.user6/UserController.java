package com.sp.user6;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/*
- @RequestParam 
	- get 방식의 파라미터를 넘겨 받을 때 주로 사용 
	- key=value&key=value 형태로 넘어온 파라미터를 메소드의 인수에 매핑하기 위해 사용 하는 어노테이션
	- 필수이므로 메소드의 인수에 파라미터가 넘어오지 않으면 400 에러가 발생. 
	- 필수가 아닌 형태로 변경 가능하고(required=false), 
	    기본값을 지정 하거나(defaultValue=" ") 
 	    파라미터와 메소드 인수와 이름이 동일하지 않은 경우에도(value="클라이언트가 지정한 이름") 매핑이 가능하다. 
*/	

@Controller("user6.userController")
@RequestMapping("/user6/*")
public class UserController {
	
	@GetMapping("main")
	public String main() { 
		return "user6/main";
	}
	
	@GetMapping("request")
	public String submit(
			@RequestParam(defaultValue="0") int age, 
			@RequestParam(value="gender", defaultValue="m") String g, 
			Model model
			) {
		
		String s1 = "성인";
		String s2 = "남자";
		
		if(age<19) {
			s1 = "미성년자";
		}
		
		if(g.equalsIgnoreCase("F")) {
			s2 = "여자";
		}
		
		model.addAttribute("age", age);
		model.addAttribute("gender", s2);
		model.addAttribute("result", s1);
		
		return "user6/view";
	}
	
	
}
