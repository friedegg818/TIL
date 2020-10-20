package com.sp.user7;

import java.util.Iterator;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("user7.userController")
@RequestMapping("/user7/*")
public class UserController {
	@GetMapping("request")
	public String form() {
		return "user7/write";
	}
/*	
	- Map으로 파라미터 넘겨 받기 
	  - @RequestParam 어노테이션이 필요 
	  - 이름이 동일한 파라미터는 하나만 넘어옴 
*/
	
	@PostMapping("request")
	public String submit(
			@RequestParam Map<String, String> paramMap,
			Model model) {
		
		String s; 
		
		s = "이름 : " + paramMap.get("name") + "<br>";
		s += "나이 : " + paramMap.get("age") + "<br>";
	//	s += "취미 : " + paramMap.get("hobby") + "<br>";
		s += "취미 : ";
		
		Iterator<String> it = paramMap.keySet().iterator();
		while(it.hasNext()) {
			String key = it.next();
			if(key.startsWith("hobby")) {
				String value = paramMap.get(key);
				s += value+" ";
			}
		}		
		
		model.addAttribute("result", s);
		
		return "user7/view";
	}
}
