package com.sp.user3;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("user3.userController")
public class UserController {
	
	@RequestMapping("/user3/hello")		// GET과 POST 모두 처리
	public void execute(HttpServletResponse resp) throws Exception {
		// return 타입 : void -> response를 직접 제어하거나 다운로드 등에서 활용 가능 
		
		resp.setContentType("text/html;charset=utf-8");
		
		PrintWriter out = resp.getWriter();
		out.println("<html><body>");
		out.println("<h3>void 리턴 타입</h3>");
		out.println("</body></html>");
	}
}
