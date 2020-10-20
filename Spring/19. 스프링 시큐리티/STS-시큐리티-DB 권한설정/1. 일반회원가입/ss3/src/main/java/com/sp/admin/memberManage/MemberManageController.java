package com.sp.admin.memberManage;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("memberManage.memberManageController")
public class MemberManageController {
	@RequestMapping(value="/admin/memberManage/info")
	public String info(HttpSession session, Model model) throws Exception {
		
		return ".admin4.menu1.memberManage.info";
	}

	@RequestMapping(value="/admin/memberManage/member")
	public String memberManage(HttpSession session, Model model) throws Exception {

		return ".admin4.menu1.memberManage.member";
	}
	
}
