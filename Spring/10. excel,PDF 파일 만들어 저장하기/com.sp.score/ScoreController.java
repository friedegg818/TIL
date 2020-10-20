package com.sp.score;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import com.sp.common.MyExcelView;
import com.sp.common.MyUtil;

@Controller("score.scoreController")
@RequestMapping("/score/*")
public class ScoreController {
	@Autowired
	private ScoreService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private MyExcelView excelView;
	
	@RequestMapping("list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="hak") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword, "UTF-8");
		}
		
		int rows=10;
		int dataCount, total_page;
		
		Map<String, Object> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page>total_page) {
			current_page=total_page;
		}
		
		int offset=(current_page-1)*rows;
		if(offset<0) offset=0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Score> list = service.listScore(map);
		
		String cp=req.getContextPath();
		String listUrl=cp+"/score/list";
		if(keyword.length()!=0) {
			listUrl+="?condition="+condition+"&keyword="
		     +URLEncoder.encode(keyword, "UTF-8");
		}
		
		String paging=myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		
		return "score/list";
	}
	
	@GetMapping("insert")
	public String insertForm(Model model) throws Exception {
		model.addAttribute("mode", "insert");
		return "score/write";
	}
	
	@PostMapping("insert")
	public String insertSubmit(Score dto, Model model) throws Exception {
		
		try {
			service.insertScore(dto);
		} catch (Exception e) {
			model.addAttribute("mode", "insert");
			model.addAttribute("msg", "학번 중복등으로 추가 실패 !!!");
			return "score/write";
		}
		
		return "redirect:/score/list";
	}
	
	@GetMapping("update")
	public String updateForm(
			@RequestParam String hak,
			@RequestParam String page,
			Model model
			) throws Exception {
		
		Score dto = service.readScore(hak);
		if(dto==null) {
			return "redirect:/score/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		
		return "score/write";
	}
	
	@PostMapping("update")
	public String updateSubmit(Score dto,@RequestParam String page) throws Exception {
		service.updateScore(dto);
		return "redirect:/score/list?page="+page;
	}
	
	@RequestMapping("delete")
	public String delete(
			@RequestParam String hak,
			@RequestParam String page
			) throws Exception {
		service.deleteScore(hak);
		return "redirect:/score/list?page="+page;
	}
	
	@RequestMapping("deleteList")
	public String deleteList(
			@RequestParam List<String> haks,
			@RequestParam String page
			) throws Exception {
		service.deleteListScore(haks);
		return "redirect:/score/list?page="+page;
	}
	
	@RequestMapping("excel")
	public View excel(Map<String, Object> model) throws Exception {
		List<Score> list = service.listAllScore();
		
		String sheetName="성적처리";
		List<String> columnLabels = new ArrayList<>();
		List<Object[]> columnValues = new ArrayList<>();
		
		columnLabels.add("학번");
		columnLabels.add("이름");
		columnLabels.add("국어");
		columnLabels.add("영어");
		columnLabels.add("수학");
		columnLabels.add("총점");
		columnLabels.add("평균");
		
		for(Score dto:list) {
			columnValues.add(new Object[] {dto.getHak(), dto.getName(), dto.getKor(),
					dto.getEng(), dto.getMat(), dto.getTot(), dto.getAve()});
		}
		
		model.put("filename", "score.xls");
		model.put("sheetName", sheetName);
		model.put("columnLabels", columnLabels);
		model.put("columnValues", columnValues);
		
		return excelView;
	}
	
	@RequestMapping("pdf")
	public View pdf(Map<String, Object> model) throws Exception {
		List<Score> list = service.listAllScore();
		
		List<String> columnLabels = new ArrayList<>();
		List<Object[]> columnValues = new ArrayList<>();
		
		columnLabels.add("학번");
		columnLabels.add("이름");
		columnLabels.add("국어");
		columnLabels.add("영어");
		columnLabels.add("수학");
		columnLabels.add("총점");
		columnLabels.add("평균");
		
		for(Score dto:list) {
			columnValues.add(new Object[] {dto.getHak(), dto.getName(), dto.getKor(),
					dto.getEng(), dto.getMat(), dto.getTot(), dto.getAve()});
		}
		
		model.put("filename", "score.pdf");
		model.put("columnLabels", columnLabels);
		model.put("columnValues", columnValues);
		
		return new ScorePdfView();
	}
}
