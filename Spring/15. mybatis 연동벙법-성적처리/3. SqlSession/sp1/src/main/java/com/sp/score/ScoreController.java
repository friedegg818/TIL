package com.sp.score;

import java.net.URLDecoder;
import java.net.URLEncoder;
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

@Controller("score.scoreController")
@RequestMapping("/score/*")
public class ScoreController {
	@Autowired
	private ScoreService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page
			,@RequestParam(defaultValue="hak") String condition
			,@RequestParam(defaultValue="") String keyword
			,HttpServletRequest req
			,Model model
			) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword, "utf-8");
		}
		
		int rows=10;
		int dataCount, total_page;
		
		Map<String, Object> map=new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount=service.dataCount(map);
		total_page=myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
		
		List<Score> list=service.listScore(map);
		
		String cp=req.getContextPath();
		String listUrl=cp+"/score/list";
		
		if(keyword.length()!=0) {
			listUrl+="?condition="+condition
			     +"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		String paging=myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "score/list";
	}
	
	@RequestMapping(value="insert", method=RequestMethod.GET)
	public String insertForm(Model model) throws Exception {
		model.addAttribute("mode", "insert");
		return "score/write";
	}
	
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public String insertSubmit(Score dto, Model model) throws Exception {
		try {
			service.insertScore(dto);
		} catch (Exception e) {
			model.addAttribute("msg", "자료를 추가하지 못했습니다.");
			model.addAttribute("mode", "insert");
			return "score/write";
		}
		
		return "redirect:/score/list";
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam String hak,
			@RequestParam String page,
			Model model) throws Exception {
		
		Score dto=service.readScore(hak);
		if(dto==null) {
			return "redirect:/score/list?page="+page;
		}
		
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		return "score/write";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(Score dto, 
			@RequestParam String page) throws Exception {
		try {
			service.updateScore(dto);
		} catch (Exception e) {
		}
		return "redirect:/score/list?page="+page;
	}
	
	@RequestMapping("delete")
	public String delete(@RequestParam String hak,
			@RequestParam String page) throws Exception {
		try {
			service.deleteScore(hak);
		} catch (Exception e) {
		}
		
		return "redirect:/score/list?page="+page;
	}
}
