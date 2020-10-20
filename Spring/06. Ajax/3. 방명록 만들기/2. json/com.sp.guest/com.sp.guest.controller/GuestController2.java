package com.sp.guest.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.guest.Guest;
import com.sp.guest.GuestService;

// AJAX : list - JSON 로 처리 
@Controller("guest.guestController2")
@RequestMapping("/guest2/*")
public class GuestController2 {
	@Autowired
	private GuestService service; 	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="guest")
	public String main() throws Exception {
		return "guest2/guest";
	}
	
	@RequestMapping(value="list")
	@ResponseBody
	public Map<String, Object> list(
			@RequestParam(value="pageNo", defaultValue="1") int current_page
			) throws Exception {
		int rows = 5;
		int dataCount = service.dataCount();
		int total_page = myUtil.pageCount(rows, dataCount);
		
		if(current_page>total_page) {
			current_page = total_page;
		}
		
		int offset = (current_page-1)*rows;
		if(offset<0) offset = 0;
		
		Map<String, Object> map = new HashMap<>();		
		map.put("offset", offset);
		map.put("rows", rows);

		List<Guest> list = service.listGuest(map);
		for(Guest dto : list) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		Map<String, Object> model = new HashMap<>();
		model.put("list", list);
		model.put("pageNo", current_page);
		model.put("dataCount", dataCount);
		model.put("paging", paging);
		
		return model;
	}	

	@RequestMapping(value="insert", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertSubmit(
				Guest dto
			) throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		try {
			service.insertGuest(dto);
			model.put("state", "true");
		} catch (Exception e) {
			model.put("state", "false");
		}
		
		return model;
	}	
	
	@RequestMapping(value="delete", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
			@RequestParam int num
			) throws Exception {
		Map<String, Object> model = new HashMap<>();
		
		try {
			service.deleteGuest(num);
			model.put("state", "true");
		} catch (Exception e) {
			model.put("state", "false");
		}
		
		return model;
	}		
	
}
