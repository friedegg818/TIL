package com.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

public class FileManager {
	public static boolean doFiledownload(String saveFilename, String originalFilename, String pathname, HttpServletResponse resp) {
		boolean flag = false;
		
		BufferedInputStream bis = null;
		OutputStream os = null;
		
		try {
			originalFilename = new String(originalFilename.getBytes("euc-kr"), "8859_1");
			pathname = pathname + File.separator + saveFilename;   // 서버에 저장된 진짜 경로 
			File f = new File(pathname);
			if(! f.exists()) {
				return flag;
			}
			
			// 클라이언트에게 전송 할 문서 타입 : 파일 
			resp.setContentType("application/octet-stream");
			
			// 파일명을 헤더에 실어서 클라이언트에게 전송 
			resp.setHeader("Content-disposition", "attachment;filename=" + originalFilename);
			
			// 클라이언트에게 파일 내용을 전송 
			byte[] b = new byte[1024];
			bis = new BufferedInputStream(new FileInputStream(f));
			
			// 클라이언트에게 전송 할 출력 스트림 			
			os = resp.getOutputStream();
			
			int n;
			while((n = bis.read(b)) != -1) {
				os.write(b, 0, n);
			}
			os.flush();			// 현재 버퍼에 저장되어 있는 내용을 클라이언트에게 전송하고 버퍼를 비움 
			
			flag = true;		// 전송 성공시 true
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(bis!=null) {
				try {
					bis.close();
				} catch (Exception e2) {
				}
			}
			
			if(os!=null) {
				try {
					os.close();
				} catch (Exception e2) {
				}
			}
		}		
		
		return flag;
	}
}
