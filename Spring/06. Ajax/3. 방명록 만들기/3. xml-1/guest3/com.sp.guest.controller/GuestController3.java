package com.sp.guest.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

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

// AJAX : xml 로 처리 
@Controller("guest.guestController3")
@RequestMapping("/guest3/*")
public class GuestController3 {
	@Autowired
	private GuestService service; 	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="guest")
	public String main() throws Exception {
		return "guest3/guest";
	}
	
	@RequestMapping(value="list")
	public String list(
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
		for(Guest dto : list) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			// dto.setContent(myUtil.htmlSymbols(dto.getContent()));
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");

		model.addAttribute("list", list);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		
		return "guest3/list";
	}

	@RequestMapping(value="insert", method=RequestMethod.POST)
	public void insertSubmit(
				Guest dto, HttpServletResponse resp
			) throws Exception {
		String state = "true";
		
		try {
			service.insertGuest(dto);			
		} catch (Exception e) {
			state = "false";
		}	
		
		String xml = "<state>" + state + "</state>";
		resp.setContentType("text/xml;charset=utf-8");		
		PrintWriter out = resp.getWriter();
		out.print(xml); 
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
