package com.sp.ts2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("ts2.demoController")
public class DemoController {
	@Autowired
	private DemoService demoService;

	@RequestMapping(value="/ts2/write", method=RequestMethod.GET)
	public String created() throws Exception{
		return "ts2/write";
	}

	@RequestMapping(value="/ts2/write", method=RequestMethod.POST)
	public String created(Demo dto, Model model) throws Exception{
		String message="추가 성공 !!!";
		try {
			demoService.insertDemo(dto);
		} catch (Exception e) {
			message = "추가 실패";
		}
		
		model.addAttribute("message", message);
		return "ts2/result";
	}
}
