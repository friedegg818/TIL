package com.sp.guest.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.guest.Guest;
import com.sp.guest.GuestService;
import com.sp.guest.xml.GuestElement;
import com.sp.guest.xml.GuestElementList;

// AJAX : xml 로 처리 
@Controller("guest.guestController4")
@RequestMapping("/guest4/*")
public class GuestController4 {
	@Autowired
	private GuestService service; 	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="guest")
	public String main() throws Exception {
		return "guest4/guest";
	}
	
	@RequestMapping(value="list")
	@ResponseBody
	public GuestElementList list(
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
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
		List<GuestElement> list2 = new ArrayList<GuestElement>();
		for(Guest dto : list) {
			GuestElement vo = new GuestElement(dto.getNum(),
				myUtil.htmlSymbols(dto.getName()),
				myUtil.htmlSymbols(dto.getContent()),
				dto.getCreated()
				);
			list2.add(vo);
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");

		GuestElementList elementList = new GuestElementList();
		
		elementList.setRecord(list2);
		elementList.setDataCount(dataCount);
		elementList.setPageNo(Integer.toString(current_page));
		elementList.setPaging(paging);
		
		return elementList;
	}

	@RequestMapping(value="insert", method=RequestMethod.POST, produces="text/xml;charset=utf-8")
	@ResponseBody
	public String insertSubmit(
				Guest dto
			) throws Exception {
		String state = "true";
		
		try {
			service.insertGuest(dto);			
		} catch (Exception e) {
			state = "false";
		}	
		
		String xml = "<state>" + state + "</state>";
		return xml;
	}	
	
	// @ResponseBody : 객체를 변환하여 응답 
	//                 String형으로 http 응답 할 경우 컨텐츠 타입은 text/plan;charset=ISO-8859-1 이다 
	// @RequestMapping의 produces 속성 : Content-type 제어 가능 
	@RequestMapping(value="delete", method=RequestMethod.POST, produces="text/xml;charset=utf-8")
	@ResponseBody
	public String delete(
			@RequestParam int num
			) throws Exception {
		
		String state = "true";
		try {
			service.deleteGuest(num);		
		} catch (Exception e) {
			state = "false";
		}			
		
		String xml = "<state>" + state + "</state>";
		return xml;		
	}		
}
