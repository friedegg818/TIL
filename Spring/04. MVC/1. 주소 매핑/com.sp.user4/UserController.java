package com.sp.user4;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("user4.userController")
public class UserController {
	
/*	
	// Map을 리턴하면 뷰의 이름은 자동으로 주소(user4/hello)가 된다.
	@RequestMapping("/user4/hello")
	public Map<String, Object> execute() throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		model.put("result", "혜화씨 반가워요...");		// 뷰에 전달 하는 값 
		return model;
	}
*/	
/*	
	@RequestMapping("/user4/hello")
	public Model execute() throws Exception {
		Model model = new ExtendedModelMap();
		
		model.addAttribute("result", "model로 리턴 ");		// 뷰에 전달 하는 값 
		return model;
	}	
*/	
	
	@RequestMapping("/user4/hello")
	public ModelMap execute() throws Exception {
		ModelMap model = new ExtendedModelMap();
		model.addAttribute("result", "ModelMap으로 리턴"); // 뷰에 전달 하는 값 
		return model;
	}
}
