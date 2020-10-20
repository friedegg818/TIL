package com.sp.common;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

@Service("common.apiSerializer")
public class APISerializer {
	// 공공 API 등의 API의 XML, JSON 문서를 String 형태로 받기 
	public String receiveToString(String spec) {
		String result = null;
		
		HttpURLConnection conn = null;
		
		try {
			conn=(HttpURLConnection) new URL(spec).openConnection();
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			StringBuilder sb = new StringBuilder();
			String s;
			while((s=br.readLine())!=null) {
				sb.append(s);
			}
			result = sb.toString();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(conn!=null) {
				try {
					conn.disconnect();
				} catch (Exception e2) {
				}
			}
		}
		
		return result;
	}
	
	// 공공 API등의 XML을 String 형태의 JSON으로 변환하여 받기 
	public String receiveXmlToJson(String spec) {
		String result = null;
		
		try {
			String s = receiveToString(spec);
/*			
			<dependency>
			    <groupId>org.json</groupId>
			    <artifactId>json</artifactId>
			    <version>20180813</version>
		    </dependency>
*/					
			JSONObject job = new JSONObject(s);
			result = job.toString();			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return result; 
	}

}
