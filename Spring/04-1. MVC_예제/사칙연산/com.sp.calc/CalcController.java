package com.sp.calc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("calc.calcController")
@RequestMapping("/calc/*")
public class CalcController {
	@Autowired
	private CalcService service;
	
	@GetMapping("request")
	public String form() {
		return "calc/write";
	}
	
	@PostMapping("request")
	// public String submit(int num1, int num2, String operator, Model model) {
	public String submit(Calc dto, Model model) {
	
		String s = service.calculator(dto);
		
		model.addAttribute("result", s);	// jsp에게 전달 할 데이터 
		
		return "calc/view";		
	}
}
