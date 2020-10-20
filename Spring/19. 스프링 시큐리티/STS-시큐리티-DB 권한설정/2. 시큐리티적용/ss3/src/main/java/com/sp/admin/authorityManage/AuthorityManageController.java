package com.sp.admin.authorityManage;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("authorityManage.authorityManageController")
public class AuthorityManageController {
	@RequestMapping(value="/admin/authorityManage/authority")
	public String authorityManage(Model model) throws Exception {
		model.addAttribute("subMenu", "3");
		return ".admin4.menu1.authorityManage.authority";
	}
}
