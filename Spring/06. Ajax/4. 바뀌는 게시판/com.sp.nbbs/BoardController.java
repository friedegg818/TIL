package com.sp.nbbs;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.FileManager;
import com.sp.common.MyUtil;

@Controller("nbbs.boardController")
public class BoardController {
	@Autowired
	private BoardService service;
	
	@Autowired
	private MyUtil myUtil;

	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/nbbs")
	public String main() throws Exception {
		return "nbbs/main";
	}

	// AJAX-Text
	@RequestMapping(value="/nbbs/list")
	public String list(
				@RequestParam(value="pageNo", defaultValue="1") int current_page,
				@RequestParam(defaultValue="all") String condition,
				@RequestParam(defaultValue="") String keyword,
				HttpServletRequest req,
				Model model) throws Exception {

		int rows=10;
		int total_page=0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map=new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount=service.dataCount(map);
		if(dataCount>0)
			total_page=myUtil.pageCount(rows, dataCount);
		
		if(current_page > total_page)
			current_page=total_page;
		
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
		
		List<Board> list=service.listBoard(map);
		
		int listNum, n=0;
		for(Board dto : list) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("list", list);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
        return "nbbs/list";
	}
	
	// AJAX-Text
	@RequestMapping(value="/nbbs/created", method=RequestMethod.GET)
	public String createdForm(Model model) throws Exception {
		model.addAttribute("mode", "created");
		return "nbbs/created";
    }
	
	// AJAX-JSON
	@RequestMapping(value="/nbbs/created", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdSubmit(
				Board dto,
				HttpServletRequest req,
				HttpSession session) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"nbbs";
		
		dto.setIpAddr(req.getRemoteAddr());
		
		String state="true";
		try {
			service.insertBoard(dto, pathname);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
    }
	
	// AJAX-Text
	@RequestMapping(value="/nbbs/article")
	public String article(
				@RequestParam int num,
				@RequestParam(defaultValue="all") String condition,
				@RequestParam(defaultValue="") String keyword,
				Model model) throws Exception {
		
		keyword=URLDecoder.decode(keyword, "utf-8");
		
		service.updateHitCount(num);
		Board dto=service.readBoard(num);
		if(dto==null) {
			return "nbbs/error";
		}
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		Map<String, Object> map=new HashMap<>();
		map.put("num", num);
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		Board preReadDto=service.preReadBoard(map);
		Board nextReadDto=service.nextReadBoard(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		
		return "nbbs/article";
	}
	
	// AJAX-JSON
	@RequestMapping(value="/nbbs/delete", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
				@RequestParam int num,
				HttpSession session) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"nbbs";
		
		String state="true";
		try {
			service.deleteBoard(num, pathname);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
    }
	
	// AJAX-Text
	@RequestMapping(value="/nbbs/update", method=RequestMethod.GET)
	public String updateForm(
				@RequestParam int num,
				Model model) throws Exception {

		Board dto = service.readBoard(num);
		if(dto==null) {
			return "nbbs/error";
		}

		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);

		return "nbbs/created";
	}
	
	// AJAX-JSON
	@RequestMapping(value="/nbbs/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSubmit(
				Board dto,
				HttpSession session) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"nbbs";
		
		String state="true";
		try {
			service.updateBoard(dto, pathname);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
    }
	
	// AJAX-JSON
	@RequestMapping(value="/nbbs/deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
				@RequestParam int num,
				HttpSession session) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "nbbs";
		
		String state="true";
		try {
			service.deleteFile(num, pathname);
		}catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/nbbs/download")
	public void download(
				@RequestParam int num,
				HttpServletResponse resp,
				HttpSession session) throws Exception{
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"nbbs";
		Board dto=service.readBoard(num);
		boolean flag=false;
		
		if(dto!=null) {
			flag=fileManager.doFileDownload(
					     dto.getSaveFilename(), 
					     dto.getOriginalFilename(), pathname, resp);
		}
		
		if(! flag) {
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out=resp.getWriter();
			out.print("<script>alert('파일 다운로드가 실패했습니다.');history.back();</script>");
		}
	}
}
