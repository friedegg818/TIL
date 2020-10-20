package com.sp.guest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;
// @RestController는 @ResponseBody를 붙이지 않아도 자바 객체가 JSON으로 변환하여 반환
// @RestController는 String을 반환하면 데이터이므로
//    jsp를 반환하기 위해서는 ModelAndView 객체에 뷰 이름(jsp)을 설정 후에 반환
@RestController("guest.guestController")
@RequestMapping("/guest/*")
public class GuestController {
	@Autowired
	private GuestService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="guest")
	public ModelAndView guest(Model model) {
		return new ModelAndView(".guest.guest");
	}
	
	@RequestMapping(value="list")
	public Map<String, Object> list(
		    @RequestParam(value="pageNo", defaultValue="1") int current_page) throws Exception {
		int rows=5;
		int dataCount=service.dataCount();
		int total_page=myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
		Map<String, Object> map = new HashMap<String, Object>();
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
		
		int listNum, n = 0;
		List<Guest> list=service.listGuest(map);
		for(Guest dto : list) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;			
		}
		
		// 페이징 처리할 경우
		// String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		// 데이터개수
		model.put("total_page", total_page);
		model.put("dataCount", dataCount);
		model.put("pageNo", current_page);
		// model.put("paging", paging);
		// 게시물 리스트
		model.put("list", list);
		
		return model;
	}
	
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public Map<String, Object> createdSubmit(
			Guest dto,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String state="true";
		try {
			dto.setUserId(info.getUserId());
			service.insertGuest(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public Map<String, Object> guestDelete(
			@RequestParam int num,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String state="true";
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("num", num);
			map.put("userId", info.getUserId());
			service.deleteGuest(map);
		} catch (Exception e) {
			state="false";
		}			
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
}
