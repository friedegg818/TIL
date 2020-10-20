package com.sp.user5;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller("user5.userController")
public class UserController {

	@GetMapping("/user5/request")
	public String form() {
		return "user5/write";
	}
	
/*	
	@PostMapping("/user5/request")
	public String submit(User dto, Model model) {
		String s = "이름 : " + dto.getName() + ", 취미 : ";
		if (dto.getHobby() != null) {
			for (String h : dto.getHobby()) {
				s += " " + h;
			}
		}

		model.addAttribute("result", s);

		return "user5/view";
	}
*/
	
/*	
	@PostMapping("/user5/request")
	public String submit(String name, String hobby, Model model) {
		// 동일한 이름을 가진 파라미터를 하나의 String 변수로 넘겨 받으면  [운동,음악] 처럼 , 로 합쳐져서 넘어온다.
		String s = "이름 :  " + name + ", 취미 : " + hobby;
		
		model.addAttribute("result", s);		
		
		return "user5/view";
	}
*/
	
	@PostMapping("/user5/request")
	public String submit(String name, String[] hobby, Model model) {
	
		String s = "이름 :  " + name + ", 취미 : ";
		
		if(hobby!=null) {
			for(String h : hobby) {
				s+=" " + h;
			}
		}
		
		model.addAttribute("result", s);		
		
		return "user5/view";
	}
	
}
