package com.sp.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("demo.demoController")
public class DemoController {
	@Autowired
	DemoService service;
	
	@RequestMapping(value="/demo/insert", method=RequestMethod.GET)
	public String write() throws Exception {
		return "demo/write";
	}
	
	@RequestMapping(value="/demo/insert", method=RequestMethod.POST)
	public String submit(Demo dto, Model model) throws Exception {
		
		String msg = "추가 성공...";
		try {
			service.insertDemo(dto);
		} catch (Exception e) {
			msg = "추가 실패...";
		}
		
		model.addAttribute("msg", msg);
		
		return "demo/result";
	}
}
