package com.file;

import java.io.File;
import java.io.IOException;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/upload/*")

@MultipartConfig(
		location = "c:/temp", // 업로드 파일을 임시로 저장하는 경로. 폴더가 없으면 업로드 안됨 
		fileSizeThreshold = 1024*1024, 	// 업로드 된 파일을 임시 경로로 보내지 않고 메모리에서 스트림으로 바로 보내는 크기 
		maxFileSize = 1024*1024*5, 		// 업로드 할 파일의 크기, 기본은 무제한 
		maxRequestSize = 1024*1024*10	// 폼 전체 용량 
)

public class UploadServlet extends HttpServlet {
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
		req.setCharacterEncoding("UTF-8");
		
		String uri = req.getRequestURI();
		
		if(uri.indexOf("write.do")!=-1) {
			RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/file/write.jsp");
			rd.forward(req, resp);
			
		} else if(uri.indexOf("write_ok.do")!=-1) {
			HttpSession session = req.getSession();
			String root = session.getServletContext().getRealPath("/");
			String pathname = root+"uploads"+File.separator+"pds";
			File f = new File(pathname);
			if(! f.exists()) {
				f.mkdirs();
			}
			
			// 파라미터 하나당 Part 하나 
			// Collection <Part> pp = req.getParts();
			
			String subject = req.getParameter("subject");
			Part p = req.getPart("selectFile");
			String originalFilename = getOriginalFilename(p);
			
			// 파일명 설정 (파일 저장 시간으로)
			String saveFilename = null;
			if(originalFilename!=null) {
				String fileExt = originalFilename.substring(originalFilename.lastIndexOf(".")); // 파일 확장자 알아내기 
				saveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
				saveFilename += System.nanoTime();
				saveFilename += fileExt;		
				
				String fullpath = pathname + File.separator+saveFilename;
				p.write(fullpath);
			}			
			
			req.setAttribute("subject", subject);	
			req.setAttribute("saveFilename", saveFilename);
			req.setAttribute("originalFilename", originalFilename);			
						
			RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/file/result.jsp");
			rd.forward(req, resp);			
		}
	}
	
	// 클라이언트가 보낸 파일 이름 찾기 
	private String getOriginalFilename(Part p) {	// part : <input type text= > 하나당 하나 (get Parameter() 하나당)
		for(String s : p.getHeader("content-disposition").split(";")) {
			if(s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=")+1).trim().replace("\"", "");
			}
		}
		return null;			
	}	
}
