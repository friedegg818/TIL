package com.sp.admin.boardManage;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("boardManage.boardManageController")
public class BoardManageController {
	@RequestMapping(value="/admin/boardManage/list")
	public String info(HttpSession session, Model model) throws Exception {
		
		return ".admin4.menu2.boardManage.list";
	}

}
