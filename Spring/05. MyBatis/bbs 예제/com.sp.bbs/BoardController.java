package com.sp.bbs;

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

@Controller("bbs.boardController")
@RequestMapping("/bbs/*")
public class BoardController {

	@Autowired
	private BoardService service;

	@Autowired
	private MyUtil myUtil;

	@RequestMapping("list")
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {

		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "UTF-8");
		}

		int rows = 10;
		int dataCount, total_page;

		Map<String, Object> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("condition", condition);

		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if (current_page > total_page) {
			current_page = total_page;
		}

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);

		List<Board> list = service.listBoard(map);

		int listNum, n = 0;
		for (Board dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}

		String cp = req.getContextPath();
		String query = "";
		String listUrl, articleUrl;

		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		listUrl = cp + "/bbs/list";
		articleUrl = cp + "/bbs/article?page=" + current_page;
		if (query.length() != 0) {
			listUrl += "?" + query;
			articleUrl += "&" + query;
		}

		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

		return "bbs/list";
	}

	@RequestMapping(value = "created", method = RequestMethod.GET)
	public String createdForm(Model model) throws Exception {
		model.addAttribute("mode", "created");
		return "bbs/created";
	}

	@RequestMapping(value = "created", method = RequestMethod.POST)
	public String createdSubmit(Board dto, HttpServletRequest req) throws Exception {
		dto.setIpAddr(req.getRemoteAddr());
		service.insertBoard(dto);

		return "redirect:/bbs/list";
	}

	@RequestMapping(value = "article", method = RequestMethod.GET)
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			Model model) throws Exception {

		keyword = URLDecoder.decode(keyword, "UTF-8");

		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		service.updateHitCount(num);
		Board dto = service.readBoard(num);
		if (dto == null) {
			return "redirect:/bbs/list?" + query;
		}

		Map<String, Object> map = new HashMap<>();
		map.put("num", num);
		map.put("condition", condition);
		map.put("keyword", keyword);

		Board preReadDto = service.preReadBoard(map);
		Board nextReadDto = service.nextReadBoard(map);

		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);

		return "bbs/article";
	}

	@RequestMapping(value = "pwd", method = RequestMethod.GET)
	public String pwdForm(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam String mode,
			Model model) throws Exception {

		model.addAttribute("num", num);
		model.addAttribute("page", page);
		model.addAttribute("mode", mode);

		return "bbs/pwd";
	}

	@RequestMapping(value = "pwd", method = RequestMethod.POST)
	public String pwdSubmit(
			@RequestParam int num,
			@RequestParam String pwd,
			@RequestParam String page,
			@RequestParam String mode, Model model) throws Exception {

		Board dto = service.readBoard(num);
		if (dto == null) {
			return "redirect:/bbs/list?page=" + page;
		}

		if (!dto.getPwd().equals(pwd)) {
			model.addAttribute("num", num);
			model.addAttribute("page", page);
			model.addAttribute("mode", mode);
			model.addAttribute("message", "패스워드가 일치하기 않습니다.");
			return "bbs/pwd";
		}

		if (mode.equals("delete")) {
			service.deleteBoard(num);
			return "redirect:/bbs/list?page=" + page;
		}

		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);

		return "bbs/created";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updatesubmit(Board dto, @RequestParam String page) throws Exception {
		
		service.updateBoard(dto);
		
		return "redirect:/bbs/list?page=" + page;
	}

}
