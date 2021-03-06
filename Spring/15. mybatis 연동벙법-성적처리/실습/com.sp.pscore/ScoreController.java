package com.sp.pscore;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;

@Controller("pscore.scoreController")
public class ScoreController {
	@Autowired
	private ScoreService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/pscore/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		int rows = 10;
		int dataCount, total_page;
		
		Map<String, Object> map = new HashMap<>();
		
		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		
		map.put("offset", offset);
		map.put("rows",  rows);
		
		List<Score> list = service.listScore(map);
		
		String cp = req.getContextPath();
		String listUrl = cp+"/pscore/list";
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		
		return "pscore/list";
	}
	
	@RequestMapping(value="/pscore/insert", method=RequestMethod.GET)
	public String insertForm(Model model) throws Exception {
		model.addAttribute("mode", "insert");
		return "pscore/write";

	}
	
	@RequestMapping(value="/pscore/insert", method=RequestMethod.POST)
	public String insertSubmit(Score dto, Model model) throws Exception {
		
		try {
			service.insertScore(dto);
		} catch (Exception e) {
			model.addAttribute("mode", "insert");
			model.addAttribute("msg", "자료추가에 실패 했습니다.");
			return "pscore/write";
		}
	
		return "redirect:/pscore/list";
	}

	@RequestMapping(value="/pscore/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam String hak, 
			@RequestParam String page,
			Model model) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		map.put("hak", hak);		
		Score dto = service.readScore(map);
		
		if(dto==null) {
			return "redirect:/pscore/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		
		return "pscore/write";
	}
	
	@RequestMapping(value="/pscore/update", method=RequestMethod.POST)
	public String updateSubmit(Score dto,
			@RequestParam String page) throws Exception {
		
		service.updateScore(dto);
		
		return "redirect:/pscore/list?page="+page;
	}
	
	@RequestMapping(value="/pscore/delete")
	public String delete(
			@RequestParam String hak, 
			@RequestParam String page) throws Exception {
		
		service.deleteScore(hak);
		
		return "redirect:/pscore/list?page="+page; 
	}
}
