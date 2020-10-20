package com.sc;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ServletConfigTest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}
	
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		// 모든 서블릿(JSP)에서 사용 가능 
		ServletContext context = getServletContext();
		// 해당 서블릿에서만 사용 가능 
		ServletConfig config = getServletConfig();
		
		try {
			String ip = context.getInitParameter("ip");
			String user = context.getInitParameter("user");
			String pwd = context.getInitParameter("pwd");
			
			String subject = config.getInitParameter("subject");
			String score = config.getInitParameter("score");
			
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			
			out.print("<html><body>");
			
			out.print("<p>ip:"+ip+" ,user:"+user+" ,pwd:"+pwd+"</p>");
			out.print("<p>subject:"+subject+" ,socre:"+score+"</p>");
			out.print("</body></html>");
			
		} catch (Exception e) {
			context.log("error:", e);
		}
	}
	
	

}
