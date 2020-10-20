package com.user1;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.GenericServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class UserServlet extends GenericServlet {		// ������ �ݵ�� ��� �޾ƾ� �� 
	private static final long serialVersionUID = 1L;

	private int count=0; 
	
	@Override
	public void init(ServletConfig config) throws ServletException {	// Ŭ���̾�Ʈ�� ���� ���� ������ �ʱ�ȭ �۾��� ���� ��� 
		super.init(config);
		
		System.out.println("������ �ʱ�ȭ �� �� �� �ѹ� �����Ѵ�.");
	}

	@Override
	public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {		
		// Ŭ���̾�Ʈ�� ��û �� ������ ����ȴ�. (��û�� �Ŀ� ����) 
		// req : Ŭ���̾�Ʈ�� ��û �� �� ���� ������ ������ �ִ� ��ü 
		// res : ��û�� ������ ���� �� �Ŀ� ���� �� ������ ������ �ִ� ��ü 
		
		try {
			
			count++;
			String msg = "���� �����Ͻ� ����<b>" + count + "</b>��° ������ �Դϴ�.";
			String str = String.format("%1$tF %1$tA %1$tT", Calendar.getInstance());
			
			// Ŭ���̾�Ʈ���� ������ ������ Ÿ�� 			
			res.setContentType("text/html; charset=utf-8");
			
			// Ŭ���̾�Ʈ���� ������ ������ ��� ��ü 
			PrintWriter out = res.getWriter();
			
			// Ŭ���̾�Ʈ���� HTML ���� ���� 
			out.print("<html>");
			out.print("<head><title>ù��° ����</title></head>");
			out.print("<body>");
			
			out.print("<p>"+msg+"</p>");
			out.print("<p>"+str+"</p>");
			
			out.print("</body>");
			out.print("</html>");
						
		} catch (Exception e) {
			getServletContext().log("error in servlet",e); // �α� ��� 
		}
		
	}
	
	@Override
	public void destroy() {
		System.out.println("������ �ı� �� �� �� �ѹ� �����Ѵ�.");
	}

}
