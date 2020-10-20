package com.sp.weather;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sp.common.APISerializer;

@Controller("weather.weatherController")
@RequestMapping("/weather/*")
public class WeatherController {
	@Autowired
	private APISerializer api;
	
	@RequestMapping(value="main", method=RequestMethod.GET)
	public ModelAndView main(ModelAndView mav) throws Exception {
		mav.setViewName("weather/main");
		return mav;
	}
	
	@RequestMapping(value="search", produces="appliction/json;charset=utf-8")
	@ResponseBody
	public String search() throws Exception {
		String result="";
		// 동네 예보
		// String urlDef="http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst";
		// 초단기 실황
		String urlDef="http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtNcst";
		// 키
		String serviceKey="Ej%2Be8XYcNOQvKTXQbXVn%2Bn6glXDzHv%2Fm9sR6%2BPz3lZa%2FIp2K2SBbcanniHMp4Lse2o8d2Rk%2Bt%2BUtFsExzCzLiw%3D%3D";
		// 한페이지 결과수
		int numOfRows=30;
		// 페이지
		int pageNo=1;
		// 날짜
		String base_date="20200615";
		// 시간
		String base_time="0930";
		// 마포구 서교동
		String nx="59";
		String ny="126";
		// 타입(XML/JSON)
		String dataType="JSON";
		
		urlDef += "?serviceKey="+serviceKey;
		urlDef += "&numOfRows="+numOfRows;
		urlDef += "&pageNo="+pageNo;
		urlDef += "&base_date="+base_date;
		urlDef += "&base_time="+base_time;
		urlDef += "&nx="+nx;
		urlDef += "&ny="+ny;
		urlDef += "&dataType="+dataType;
		
		result = api.receiveToString(urlDef);
		
		return result;
	}

	@RequestMapping(value="search2", produces="appliction/json;charset=utf-8")
	@ResponseBody
	public String search2(
			@RequestParam String base_date,
			@RequestParam String base_time,
			@RequestParam String nx,
			@RequestParam String ny
			) throws Exception {
		String result="";
		// 초단기 예보
		String urlDef="http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtFcst";
		// 키
		String serviceKey="Ej%2Be8XYcNOQvKTXQbXVn%2Bn6glXDzHv%2Fm9sR6%2BPz3lZa%2FIp2K2SBbcanniHMp4Lse2o8d2Rk%2Bt%2BUtFsExzCzLiw%3D%3D";
		// 한페이지 결과수
		int numOfRows=30;
		// 페이지
		int pageNo=1;
		// 타입(XML/JSON)
		String dataType="JSON";
		
		urlDef += "?serviceKey="+serviceKey;
		urlDef += "&numOfRows="+numOfRows;
		urlDef += "&pageNo="+pageNo;
		urlDef += "&base_date="+base_date;
		urlDef += "&base_time="+base_time;
		urlDef += "&nx="+nx;
		urlDef += "&ny="+ny;
		urlDef += "&dataType="+dataType;
		
		result = api.receiveToString(urlDef);
		
		return result;
	}
	
}
