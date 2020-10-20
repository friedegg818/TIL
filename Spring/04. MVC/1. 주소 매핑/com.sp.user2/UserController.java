package com.sp.user2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

// @Controller : 객체 생성 및 컨트롤러 역할을 한다. 
@Controller("user2.userController")
public class UserController {
	@Autowired
	private UserService service;
	
//  주소 매핑 
//  @RequestMapping(value="/user2/request) : GET , POST 방식 모두 처리 	
	
//  @GetMapping("/user2/request")	
	@RequestMapping(value="/user2/request", method=RequestMethod.GET)
	public String form() {
		return "user2/write";	// 뷰(jsp) 이름 
	}
	
//  @PostMapping("/user2/request")	
	@RequestMapping(value="/user2/request", method=RequestMethod.POST)
	public ModelAndView submit(String name, String tel, int age) {
		// 메소드의 인수명과 request 파라미터의 이름이 동일한 경우 파라미터를 전달 받는다.
		
		String s = service.message(age);
		
		// ModelAndView : 컨트롤러 처리 결과를 보여 줄 뷰와 뷰에 전달 할 값을 저장하는 용도 (req.setAttribute 역할)
		ModelAndView mav = new ModelAndView("user2/view");	// 생성자의 인수는 뷰 이름
		mav.addObject("name", name);
		mav.addObject("tel", tel);
		mav.addObject("result", s);
		return mav;
	}
}
