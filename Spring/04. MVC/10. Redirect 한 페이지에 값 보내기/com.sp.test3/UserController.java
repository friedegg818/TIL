package com.sp.test3;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("test3.userController")
public class UserController {
	@RequestMapping(value="/test3/request", method=RequestMethod.GET)
	public String form() {
		return "test3/write";
	}
	
	@RequestMapping(value="/test3/request", method=RequestMethod.POST)
	public String submit(User dto, RedirectAttributes rattr) {		
		// RedirectAttributes : 리다이렉트 된 페이지에 값을 보낼 수 있다.
	
		System.out.println("dto 저장...");
		
		// 리다이렉트 된 페이지에 남길 값 (한번만 사용 가능)
		// F5 키를 눌러 새로고침 하면 사라짐 
		rattr.addFlashAttribute("dto", dto);
		rattr.addFlashAttribute("msg", "end..");
		
		return "redirect:/test3/show";                        //   insert/update/delete 후에는 forward 하지 않는다 (DB가 새롭게 업데이트 되므로) 
	}
	
	@RequestMapping("/test3/show")
	public String view(@ModelAttribute("dto") User dto) {
		// 리다이렉트 전 페이지의 값을  이곳으로 넘겨 받는 방법
		// 메소드의 인수에 @ModelAttribute 어노테이션을 사용한다.
		
		// 새로고침하면 null 됨
    	System.out.println("이름:" + dto.getName());
		
		return "test3/view";
	}
}
