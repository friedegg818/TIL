package com.sp.admin.blogManage;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("blogManage.blogManageController")
public class BlogManageController {
	@RequestMapping(value="/admin/blogManage/list")
	public String info(HttpSession session, Model model) throws Exception {
		
		return ".admin4.menu2.blogManage.list";
	}

}
