package com.user1;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.GenericServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class UserServlet extends GenericServlet {		// 서블릿은 반드시 상속 받아야 함 
	private static final long serialVersionUID = 1L;

	private int count=0; 
	
	@Override
	public void init(ServletConfig config) throws ServletException {	// 클라이언트와 관계 없이 서버의 초기화 작업을 위해 사용 
		super.init(config);
		
		System.out.println("서블릿이 초기화 될 때 단 한번 실행한다.");
	}

	@Override
	public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {		
		// 클라이언트가 요청 할 때마다 실행된다. (요청한 후에 응답) 
		// req : 클라이언트가 요청 할 때 보낸 정보를 가지고 있는 객체 
		// res : 요청한 정보를 실행 한 후에 응답 할 정보를 가지고 있는 객체 
		
		try {
			
			count++;
			String msg = "지금 접속하신 분은<b>" + count + "</b>번째 접속자 입니다.";
			String str = String.format("%1$tF %1$tA %1$tT", Calendar.getInstance());
			
			// 클라이언트에게 보내는 문서의 타입 			
			res.setContentType("text/html; charset=utf-8");
			
			// 클라이언트에게 문서를 전송할 출력 객체 
			PrintWriter out = res.getWriter();
			
			// 클라이언트에게 HTML 문서 전송 
			out.print("<html>");
			out.print("<head><title>첫번째 예제</title></head>");
			out.print("<body>");
			
			out.print("<p>"+msg+"</p>");
			out.print("<p>"+str+"</p>");
			
			out.print("</body>");
			out.print("</html>");
						
		} catch (Exception e) {
			getServletContext().log("error in servlet",e); // 로그 출력 
		}
		
	}
	
	@Override
	public void destroy() {
		System.out.println("서블릿이 파괴 될 때 단 한번 실행한다.");
	}

}
