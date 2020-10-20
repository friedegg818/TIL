package com.util;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBCPConn {
	private static DataSource ds = null;
	
	private DBCPConn() {		
	}
	
	public static Connection getConnection() {
		Connection conn = null;
		
		try {
			if(ds == null) {
				// context.xml 파일을 읽어서 Context 객체를 생성 
				Context ctx = new InitialContext();
				
				// 이름에 바인딩 된 객체를 찾아 반환 : java:/comp/env
				Context context = (Context)ctx.lookup("java:/comp/env");
				
				ds = (DataSource)context.lookup("jdbc/myoracle");				
			}
			
			conn = ds.getConnection();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	public static void close(Connection conn) {
		if(conn==null) return;
		
		try {
			if(! conn.isClosed()) {
				conn.close();				
			}
		} catch (Exception e) {
		}
		
		conn = null;
	}

}
