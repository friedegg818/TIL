package com.sp.guest.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.sp.common.MyUtil;
import com.sp.guest.Guest;
import com.sp.guest.GuestService;

// AJAX : list - JSON 로 처리 
// @RestController : REST 방식을 위한 컨트롤러. spring 4부터 사용 가능 
// JSON 또는 XML에 최적화된 컨트롤러 
// @ResponseBody 없이도 컨트롤러를 통해 자동으로  JSON 등으로 변환 
@RestController("guest.guestController5")
@RequestMapping("/guest5/*")
public class GuestController5 {
	@Autowired
	private GuestService service; 	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="guest")
	public ModelAndView main() throws Exception {
		/* @RestControler에서 String은 데이터로 반환된다. 
		         이 때 반환된 데이터 컨텐츠 타입은 text/plan;charset=ISO-8859-1 이다.
		    @RequestMapping의 produces 속성으로 Content-Type 제어 가능 
		    JSP를 반환해야 하는 경우에는 JSP 이름을 설정한 ModelAndView 객체 반환 */
		
		ModelAndView mav = new ModelAndView("guest5/guest"); // jsp 명 
	//	mav.setViewName("guest5/guest"); 
		
		return mav;
	}
	
	@RequestMapping(value="list")
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
