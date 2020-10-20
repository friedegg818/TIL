package com.sp.sbbs;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("sbbs.boardController")
@RequestMapping("/sbbs/*")
public class BoardController {
	@Autowired
	private BoardService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="0") int group,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
   	    String cp = req.getContextPath();
   	    
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
        // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("group", group);
        map.put("condition", condition);
        map.put("keyword", keyword);

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows, dataCount) ;

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);

        // 글 리스트
        List<Board> list = service.listBoard(map);

        // 리스트의 번호
        int listNum, n = 0;
        for(Board dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/sbbs/list?group="+group;
        String articleUrl = cp+"/sbbs/article?group="+group+"&page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl += "&" + query;
        	articleUrl += "&" + query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);
        
        Map<String, Object> map2 = new HashMap<String, Object>();
        map2.put("parent", null);
        List<Board> groupList = service.listCategory(map2);

        model.addAttribute("list", list);
        model.addAttribute("group", group);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

        model.addAttribute("groupList", groupList);
		
		return ".sbbs.list";
	}
	
	@RequestMapping(value="created", method=RequestMethod.GET)
	public String createdForm(
			Model model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 대분류
		map.put("parent", null);
		List<Board> groupList = service.listCategory(map);

/*		
		List<Board> subclassList = null;
		if(groupList!=null && groupList.size()>0) {
			map.put("parent", groupList.get(0).getCategoryNum());
			subclassList = service.listCategory(map);
		}
		model.addAttribute("subclassList", subclassList);
*/

		model.addAttribute("mode", "created");
		model.addAttribute("groupList", groupList);
		
		return ".sbbs.created";
	}
	
	@RequestMapping(value="created", method=RequestMethod.POST)
	public String createdSubmit(
			Board dto,
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setUserId(info.getUserId());
			service.insertBoard(dto);
		} catch (Exception e) {
			
		}
		
		return "redirect:/sbbs/list";
	}
	
	@RequestMapping(value="subclass", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> subclassList(
			@RequestParam int categoryNum
			) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("parent", categoryNum);
		List<Board> subclassList = service.listCategory(map);
		
		Map<String, Object> model = new HashMap<>();
		model.put("subclassList", subclassList);
		return model;
	}
	
	@RequestMapping(value="article")
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam int group,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query = "group="+group+"&page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}

		service.updateHitCount(num);

		// 해당 레코드 가져 오기
		Board dto = service.readBoard(num);
		if(dto==null)
			return "redirect:/sbbs/list?"+query;
		
        dto.setContent(myUtil.htmlSymbols(dto.getContent()));
        
		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group", group);
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);

		Board preReadDto = service.preReadBoard(map);
		Board nextReadDto = service.nextReadBoard(map);
        
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);

		model.addAttribute("group", group);
		model.addAttribute("page", page);
		model.addAttribute("query", query);

        return ".sbbs.article";
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam int group,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Board dto = service.readBoard(num);
		if(dto==null) {
			return "redirect:/sbbs/list?group="+group+"&page="+page;
		}

		if(! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/sbbs/list?group="+group+"&page="+page;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 대분류
		map.put("parent", null);
		List<Board> groupList = service.listCategory(map);
		
		// 중분류
		map.put("parent", dto.getGroupCategoryNum());
		List<Board> subclassList = service.listCategory(map);

		model.addAttribute("dto", dto);
		model.addAttribute("group", group);
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		
		model.addAttribute("groupList", groupList);
		model.addAttribute("subclassList", subclassList);
		
		return ".sbbs.created";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Board dto,
			@RequestParam int group,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setUserId(info.getUserId());
			service.updateBoard(dto);
		} catch (Exception e) {
			
		}
		
		return "redirect:/sbbs/list?group="+group+"&page="+page;
	}

	@RequestMapping(value="delete")
	public String delete(
			@RequestParam int num,
			@RequestParam int group,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="group="+group+"&page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("num", num);
		map.put("userId", info.getUserId());
		
		service.deleteBoard(map);
		
		return "redirect:/sbbs/list?"+query;
	}
	
	// 댓글 ---------------------------
	// 댓글 리스트 : AJAX-TEXT
	@RequestMapping(value="listReply")
	public String listReply(
			@RequestParam int num,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			) throws Exception {
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map=new HashMap<>();
		map.put("num", num);
		
		dataCount=service.replyCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
		List<Reply> listReply=service.listReply(map);
		
		for(Reply dto : listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		// AJAX 용 페이징
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		// 포워딩할 jsp로 넘길 데이터
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "sbbs/listReply";
	}
	
	// 댓글 등록 : AJAX-JSON
	@RequestMapping(value="insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
			Reply dto,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertReply(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	// 댓글 삭제 : AJAX-JSON
	@RequestMapping(value="deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(
			@RequestParam Map<String, Object> paramMap
			) {
		
		String state="true";
		try {
			service.deleteReply(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		return map;
	}
}
