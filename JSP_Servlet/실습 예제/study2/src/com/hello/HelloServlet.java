package com.hello;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 클라이언트 요청이 GET 방식인 경우 실행 
		
		try {
			// 클라이언트가 보낸 정보 받기
			String name = req.getParameter("name");
			int age = Integer.parseInt(req.getParameter("age"));
			String msg = name + "님 반가워요<br>";
			if(age>=19) {
				msg += name+"님은 <span style='color:red;'> 성인 </span>입니다.";
			} else {
				msg += name+"님은 <span style='color:red;'> 미성년자 </span>입니다.";
			}
			
			// 클라이언트에게 전송하는 문서 타입 
			resp.setContentType("text/html; charset=utf-8");
		
			// 클라이언트에게 정보를 전송할 수 있는출력 스트림 
			PrintWriter out = resp.getWriter();
			
			out.println("<html>");
			out.println("<head><title>예제</title></head>");
			out.println("<body>");
			out.println("<h3>GET 방식을 요청</h3>");
			
			out.println(msg);
			
			out.println("</body>");
			out.println("</html>");			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 클라이언트 요청이 POST 방식인 경우 실행 
		
		try {
			// 클라이언트가 전송한 문서 타입 설정 (설정하지 않으면 한글 처리 불가)
			req.setCharacterEncoding("UTF-8");
			
			// 클라이언트가 보낸 정보 받기 
			String name = req.getParameter("name");
			int age = Integer.parseInt(req.getParameter("age"));
			String msg = name + "님 반가워요<br>";
			if(age>=19) {
				msg += name+"님은 <span style='color:green;'> 성인 </span>입니다.";
			} else {
				msg += name+"님은 <span style='color:green;'> 미성년자 </span>입니다.";
			}			
			
			// 클라이언트에게 전송하는 문서 타입 
			resp.setContentType("text/html; charset=utf-8");
				
			// 클라이언트에게 정보를 전송할 수 있는출력 스트림 
			PrintWriter out = resp.getWriter();
					
			out.println("<html>");
			out.println("<head><title>예제</title></head>");
			out.println("<body>");
			out.println("<h3>POST 방식을 요청</h3>");
			
			out.println(msg);
					
			out.println("</body>");
			out.println("</html>");			
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}	

}
