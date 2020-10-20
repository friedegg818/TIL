package com.sp.chat;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChattingController {
	@RequestMapping(value="/chat/main")
	public String main() throws Exception {
		return ".chat.chat";
	}
}
