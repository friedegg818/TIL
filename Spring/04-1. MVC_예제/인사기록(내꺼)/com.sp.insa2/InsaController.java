package com.sp.insa2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("insa2.insaController")
@RequestMapping("/insa2/*")
public class InsaController {
	@Autowired
	private InsaService service;
	
	@GetMapping("request")
	public String form() {
		return "insa2/write";
	}
	
	@PostMapping("request")
	public String submit(Insa dto, int sal, int bonus, String birth, Model model) {
		int tax = service.tax(sal, bonus);
		int pay = service.pay(sal, bonus, tax);
		int age = service.age(birth);
		String ani = service.ani(birth);
		
		model.addAttribute("dto", dto);
		model.addAttribute("tax", tax);
		model.addAttribute("pay", pay);
		model.addAttribute("age", age);
		model.addAttribute("ani", ani);
		
		return "insa2/view";		
	}

}
