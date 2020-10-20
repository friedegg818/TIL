package com.sp.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.APISerializer;

@Controller("user.userController")
public class UserController {
	@Autowired
	private UserService service;
	
	@Autowired
	private APISerializer api;
	
	@RequestMapping("/user/main")
	public String main() throws Exception {
		return "user/main";
	}
	
	@RequestMapping("/user/list")
	@ResponseBody	
	public Map<String, Object> list(HttpServletRequest req) throws Exception {
		String cp = req.getContextPath();
		// String spec = "http://localhost:9090/sp2/xml/userXML.xml";
		String spec = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+cp+"/xml/userXML.xml";
		
		Map<String, Object> model = service.serializeNode(spec);
		
		return model;
	}
	
	@RequestMapping(value="/user/list2", produces="appliction/xml;charset=utf-8")		
	@ResponseBody
	public String list2(HttpServletRequest req) throws Exception {
		// XML을 String으로 반환 
		String cp = req.getContextPath();		
		String spec = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+cp+"/xml/userXML.xml";
		
		String result = api.receiveToString(spec);
		
		return result;
	}
	
	
}
