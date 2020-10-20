package com.sp.cboard;

import java.io.File;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.admin.boardManage.BoardManage;
import com.sp.admin.boardManage.BoardManageService;
import com.sp.common.FileManager;
import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("cboard.boardController")
@RequestMapping("/cb/*")
public class BoardController {
	@Autowired
	private BoardService service;
	@Autowired
	private BoardManageService mservice;
	
	@Autowired
	private MyUtil myUtil;

	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="{board}/list")
	public String list(
			@PathVariable String board,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
   	    BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	return "redirect:/";
   	    }
        String uri=req.getRequestURI().substring(0, req.getRequestURI().indexOf(board)+board.length());        
   	    
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
        // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("tableName", bm.getBoard());
        map.put("condition", condition);
        map.put("keyword", keyword);
        map.put("answer", bm.getAnswer());

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows,  dataCount) ;

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
        Date endDate = new Date();
        long gap;
        int listNum, n = 0;
        for(Board dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date beginDate = formatter.parse(dto.getCreated());
/*            
            // 날짜차이(일)
            gap=(endDate.getTime() - beginDate.getTime()) / (24 * 60 * 60* 1000);
            dto.setGap(gap);
*/
         // 날짜차이(시간)
            gap=(endDate.getTime() - beginDate.getTime()) / (60*60* 1000);
            dto.setGap(gap);
            
            dto.setCreated(dto.getCreated().substring(0, 10));
            
            n++;
        }
        
        if(bm.getNotice()==1 && current_page==1) {
        	List<Board> listTop = service.listBoardTop(map);
        	for(Board dto : listTop) {
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date beginDate = formatter.parse(dto.getCreated());
                gap=(endDate.getTime() - beginDate.getTime()) / (60*60* 1000);
                dto.setGap(gap);
                
                dto.setCreated(dto.getCreated().substring(0, 10));
            }
        	model.addAttribute("listTop", listTop);
        }
        
        String query = "";
        String listUrl = ""; 
        String articleUrl = "";
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	        "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()==0) {
        	listUrl = uri+"/list";
        	articleUrl = uri+"/article?page=" + current_page;
        } else {
        	listUrl = uri+"/list?" + query;
        	articleUrl = uri+"/article?page=" + current_page + "&"+ query;
        }

        String viewFile=".cboard.list";
        
        model.addAttribute("bm", bm);
        model.addAttribute("list", list);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", myUtil.paging(current_page, total_page, listUrl));		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		model.addAttribute("uri", uri);
		
		return viewFile;
	}

	@RequestMapping(value="{board}/created", method=RequestMethod.GET)
	public String createdForm(
			          @PathVariable String board,
			          HttpServletRequest req,
			          HttpSession session,
			          Model model) throws Exception {
		
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	return "redirect:/";
   	    }
   	    String uri=req.getRequestURI().substring(0, req.getRequestURI().indexOf(board)+board.length());		
 		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		if(bm.getUpdateMembership()>info.getMembership()) {
			return ".member.noAuthorized";
		}
		
        String viewFile=".cboard.created";

		model.addAttribute("bm", bm);
		model.addAttribute("mode", "created");
		model.addAttribute("uri", uri);

		return viewFile;
	}
	
	@RequestMapping(value="{board}/created", method=RequestMethod.POST)
	public String createdSubmit(
			@PathVariable String board,
			Board dto,
			HttpServletRequest req,
			HttpSession session) throws Exception {
		
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	return "redircet:/";
   	    }
		String uri=req.getRequestURI().substring(0, req.getRequestURI().indexOf(board)+board.length());
		String redirectUri=uri;
		if(redirectUri.indexOf(req.getContextPath())==0) {
			redirectUri=redirectUri.substring(req.getContextPath().length());
		}
 		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(bm.getUpdateMembership()>info.getMembership()) {
			return ".member.noAuthorized";
		}
		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "cboard";		
			
			dto.setTableName(bm.getBoard());
			dto.setUserId(info.getUserId());
			service.insertBoard(dto, "created", pathname);
		} catch (Exception e) {
		}
		
		return "redirect:"+redirectUri+"/list";
	}
	
	// 글보기
	@RequestMapping(value="{board}/article", method=RequestMethod.GET)
	public String article(
			@PathVariable String board,
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
		
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	return "redirect:/";
   	    }
		String uri=req.getRequestURI().substring(0, req.getRequestURI().indexOf(board)+board.length());
		String redirectUri=uri;
		if(redirectUri.indexOf(req.getContextPath())==0) {
			redirectUri=redirectUri.substring(req.getContextPath().length());
		}
   	    
   	    keyword = URLDecoder.decode(keyword, "utf-8");
   	 
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", bm.getBoard());
		map.put("answer", bm.getAnswer());
		map.put("num", num);
		
		service.updateHitCount(map);

		Board dto = service.readBoard(map);
		if(dto==null)
			return "redirect:"+redirectUri+"/list?"+query;
		
        dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
        
		// 이전 글, 다음 글
		map.put("condition", condition);
		map.put("keyword", keyword);
		if(bm.getAnswer()==1) {
			map.put("groupNum", dto.getGroupNum());
			map.put("orderNo", dto.getOrderNo());
		}

		Board preReadDto = service.preReadBoard(map);
		Board nextReadDto = service.nextReadBoard(map);
        
		// 파일
		List<Board> listFile=service.listFile(map);
		
		// 게시물 좋아요 개수
		int boardLikeCount=0;
		if(bm.getBoardLike()==1) {
			boardLikeCount = service.boardLikeCount(map);
		}

        String viewFile=".cboard.article";
        		
		model.addAttribute("bm", bm);
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("boardLikeCount", boardLikeCount);

		model.addAttribute("page", page);
		model.addAttribute("query", query); // 이전과 다음에 사용할 인수
		model.addAttribute("uri", uri);

		return viewFile;
	}
	
	// 게시물 좋아요 추가
	@RequestMapping(value="{board}/insertBoardLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertBoardLike(
			@PathVariable String board,
			Board dto,
			HttpSession session) throws Exception {
	
		SessionInfo info=(SessionInfo) session.getAttribute("member");
		String state="true";
		int boardLikeCount=0;
		
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	state="noTable";
   	    } else {
   			try {
   				dto.setTableName(bm.getBoard());
   				dto.setUserId(info.getUserId());
   				service.insertBoardLike(dto);
   				
   				Map<String, Object> map = new HashMap<>();
   				map.put("tableName", bm.getBoard());
   				map.put("num", dto.getNum());
   				boardLikeCount=service.boardLikeCount(map);
   			} catch (Exception e) {
   				state="false";
   			}
   	    }
   	    
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		model.put("boardLikeCount", boardLikeCount);
		return model;
	}
	
	// 수정 폼
	@RequestMapping(value="{board}/update", method=RequestMethod.GET)
	public String updateForm(
			@PathVariable String board,
			@RequestParam int num,
			@RequestParam String page,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
		
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	return "redircet:/";
   	    }
		String uri=req.getRequestURI().substring(0, req.getRequestURI().indexOf(board)+board.length());
		String redirectUri=uri;
		if(redirectUri.indexOf(req.getContextPath())==0) {
			redirectUri=redirectUri.substring(req.getContextPath().length());
		}
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(bm.getUpdateMembership()>info.getMembership()) {
			return ".member.noAuthorized";
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", bm.getBoard());
		map.put("num", num);
		
		Board dto = (Board) service.readBoard(map);
		if(dto==null) {
			return "redirect:"+redirectUri+"/list?page="+page;
		}
		
		if(! info.getUserId().equals(dto.getUserId())) {
			return ".member.noAuthorized";
		}

		List<Board> listFile=service.listFile(map);
			
        String viewFile=".cboard.created";
        
		model.addAttribute("bm", bm);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("uri", uri);
		
		return viewFile;
	}

	// 수정 완료
	@RequestMapping(value="{board}/update", method=RequestMethod.POST)
	public String updateSubmit(
			@PathVariable String board,
			Board dto,
			@RequestParam String page,
			HttpServletRequest req,
			HttpSession session) throws Exception {
		
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	return "redircet:/";
   	    }
   	    String uri=req.getRequestURI().substring(0, req.getRequestURI().indexOf(board)+board.length());
		String redirectUri=uri;
		if(redirectUri.indexOf(req.getContextPath())==0) {
			redirectUri=redirectUri.substring(req.getContextPath().length());
		} 
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(bm.getUpdateMembership()>info.getMembership()) {
			return ".member.noAuthorized";
		}		
		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "cboard";		
			
			dto.setTableName(bm.getBoard());
			dto.setUserId(info.getUserId());
			service.updateBoard(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:"+redirectUri+"/list?page="+page;
	}

	// 게시물 삭제
	@RequestMapping(value="{board}/delete", method=RequestMethod.GET)
	public String delete(
			@PathVariable String board,
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			HttpSession session) throws Exception {
		
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	return "redirect:/";
   	    }
		String uri=req.getRequestURI().substring(0, req.getRequestURI().indexOf(board)+board.length());
		String redirectUri=uri;
		if(redirectUri.indexOf(req.getContextPath())==0) {
			redirectUri=redirectUri.substring(req.getContextPath().length());
		}
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "cboard";		
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", bm.getBoard());
		map.put("num", num);
		map.put("pathname", pathname);
		
		Board dto = (Board) service.readBoard(map);
		if(dto==null) {
			return "redirect:"+redirectUri+"/list?"+page;
		}
		
		if(! info.getUserId().equals(dto.getUserId()) &&
				 (bm.getUpdateMembership() > info.getMembership() || ( dto.getGroupNum()!=0 && bm.getAnswerMembership() > info.getMembership()))) {
			return ".member.noAuthorized";
		}
		
		try {
			service.deleteBoard(map);
		} catch (Exception e) {
		}
		
		return "redirect:"+redirectUri+"/list?"+query;
	}

	// 답변 폼
	@RequestMapping(value="{board}/answer", method=RequestMethod.GET)
	public String answerForm(
			@PathVariable String board,
			@RequestParam int num,
			@RequestParam String page,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
		
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	return "redirect:/";
   	    }
		String uri=req.getRequestURI().substring(0, req.getRequestURI().indexOf(board)+board.length());
		String redirectUri=uri;
		if(redirectUri.indexOf(req.getContextPath())==0) {
			redirectUri=redirectUri.substring(req.getContextPath().length());
		}
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(bm.getAnswerMembership()>info.getMembership()) {
			return ".member.noAuthorized";
		}		
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", bm.getBoard());
		map.put("num", num);
		
		Board dto = service.readBoard(map);
		if (dto == null) {
			return "redirect:"+redirectUri+"/list?page="+page;
		}

		String str = "["+dto.getSubject()+"] 에 대한 답변입니다.\n";
		dto.setContent(str);

        String viewFile=".cboard.created";
        
		model.addAttribute("bm", bm);
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "answer");
		model.addAttribute("uri", uri);

		return viewFile;
	}

	// 답변 완료
	@RequestMapping(value="{board}/answer", method = RequestMethod.POST)
	public String answerSubmit(
			@PathVariable String board,
			Board dto,
			@RequestParam String page,
			HttpServletRequest req,
			HttpSession session) throws Exception {
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	return "redirect:/";
   	    }
		String uri=req.getRequestURI().substring(0, req.getRequestURI().indexOf(board)+board.length());
		String redirectUri=uri;
		if(redirectUri.indexOf(req.getContextPath())==0) {
			redirectUri=redirectUri.substring(req.getContextPath().length());
		}
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if(bm.getAnswerMembership()>info.getMembership()) {
			return ".member.noAuthorized";
		}

		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "cboard";		
			
			dto.setTableName(bm.getBoard());
			dto.setUserId(info.getUserId());
			service.insertBoard(dto, "answer", pathname);
		} catch (Exception e) {
		}
		
		return "redirect:"+redirectUri+"/list?page="+page;
	}
	
	// 다운로드
	@RequestMapping(value="{board}/download")
	public void download(
			@PathVariable String board,
			@RequestParam int fileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	return;
   	    }
 		
		String root = session.getServletContext().getRealPath("/");
		String path = root + "uploads" + File.separator + "cboard";

		boolean b=false;

		Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", bm.getBoard());
		map.put("fileNum", fileNum);
		
		Board dto = service.readFile(map);
		if(dto!=null) {
			String saveFilename = dto.getSaveFilename();
			String originalFilename = dto.getOriginalFilename();
			
			b = fileManager.doFileDownload(saveFilename, originalFilename, path, resp);
		}
		
		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}
	
	// 파일삭제
	@RequestMapping(value="{board}/deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@PathVariable String board,
			@RequestParam int fileNum,
			HttpSession session) throws Exception {
		
		String state="false";
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   			Map<String, Object> model = new HashMap<>(); 
   			model.put("state", state);
   			return model;
   	    }
 		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "cboard";
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", bm.getBoard());
		map.put("fileNum", fileNum);
			
		Board dto=service.readFile(map);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		
		state="true";
		try {
			map.put("field", "fileNum");
			map.put("num", fileNum);
			service.deleteFile(map);
		} catch (Exception e) {
			state="false";
		}
		
		// 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	//---------------------------------------------------------------------
	// 댓글 리스트
	@RequestMapping(value="{board}/listReply")
	public String listReply(
			@PathVariable String board,
			@RequestParam int num,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			HttpServletResponse resp,
			Model model) throws Exception {
		
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	resp.sendError(510);
   	    	return null;
   	    }
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", bm.getBoard());
		map.put("num", num);
		
		dataCount=service.replyCount(map);
		total_page=myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
		// 리스트에 출력할 데이터
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
		List<Reply> listReply=service.listReply(map);
		
		// 엔터를 <br>
		int listNum, n=0;
		for(Reply dto : listReply) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			dto.setContent(myUtil.htmlSymbols(dto.getContent()));
			n++;
		}
		
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		// jsp로 넘길 데이터
		model.addAttribute("listReply", listReply);
		model.addAttribute("bm", bm);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "cboard/listReply";
	}

	// 댓글별 답글 리스트
	@RequestMapping(value="{board}/listReplyAnswer")
	public String listReplyAnswer(
			@PathVariable String board,
			@RequestParam int answer,
			HttpServletResponse resp,
			Model model) throws Exception {

		BoardManage cb=mservice.readBoardManage(board);
   	    if(cb==null) {
   	    	resp.sendError(510);
   	    	return null;
   	    }
   	    
   	    Map<String, Object> map=new HashMap<String, Object>();
		map.put("tableName", cb.getBoard());
		map.put("answer", answer);
		
		List<Reply> listReplyAnswer=service.listReplyAnswer(map);
		
		// 엔터를 <br>
		for(Reply dto : listReplyAnswer) {
			dto.setContent(myUtil.htmlSymbols(dto.getContent()));
		}
		
		// jsp로 넘길 데이터
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		
		return "cboard/listReplyAnswer";
	}
	
	// 댓글별 답글 개수
	@RequestMapping(value="{board}/countReplyAnswer")
	@ResponseBody
	public Map<String, Object> countReplyAnswer(
			@PathVariable String board,
			@RequestParam int answer) throws Exception {

		String state="true";
		int count=0;
		
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	state="noTable";
   	    } else { 
   	   	    Map<String, Object> map=new HashMap<String, Object>();
   			map.put("tableName", bm.getBoard());
   			map.put("answer", answer);
  	    
   	    	count=service.replyAnswerCount(map);
   	    }
   	    
   	    Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		model.put("count", count);
		
		// 작업 결과를 json으로 전송
		return model;
	}
	
	// 댓글 및 리플별 답글 추가
	@RequestMapping(value="{board}/insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
			@PathVariable String board,
			Reply dto,
			HttpSession session) throws Exception {
	
		SessionInfo info=(SessionInfo) session.getAttribute("member");
		String state="true";
		
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	state="noTable";
   	    } else {
   			try {
   				dto.setTableName(bm.getBoard());
   				dto.setUserId(info.getUserId());
   				service.insertReply(dto);
   			} catch (Exception e) {
   				state="false";
   			}
   	    }
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	// 댓글 및 댓글별답글 삭제
	@RequestMapping(value="{board}/deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(
			@PathVariable String board,
			@RequestParam int replyNum,
			@RequestParam String mode,
			HttpSession session) throws Exception {
		
		String state="true";
		
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	state="noTable";
   	    } else {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("tableName", bm.getBoard());
			map.put("mode", mode);
			map.put("replyNum", replyNum);
	
			// 좋아요/싫어요 는 ON DELETE CASCADE 로 자동 삭제
            // 댓글삭제
			try {
				service.deleteReply(map);
			} catch (Exception e) {
				state="false";
			}
   	    }
   	    
		// 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	// 좋아요/싫어요 추가
	@RequestMapping(value="{board}/insertReplyLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReplyLike(
			@PathVariable String board,
			@RequestParam Map<String, Object> paramMap,
			HttpSession session) throws Exception {
	
		SessionInfo info=(SessionInfo) session.getAttribute("member");
		String state="true";
		Map<String, Object> model = new HashMap<>(); 

		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	state="noTable";
   	    } else {
   			try {
   				paramMap.put("tableName", bm.getBoard());
   				paramMap.put("userId", info.getUserId());
   				service.insertReplyLike(paramMap);
   			} catch (Exception e) {
   				state="false";
   			}
			
			Map<String, Object> countMap=service.replyLikeCount(paramMap);
			
			// 마이바티스의 resultType이 map인 경우 int는 BigDecimal로 넘어옴
			int likeCount=((BigDecimal)countMap.get("LIKECOUNT")).intValue();
			int disLikeCount=((BigDecimal)countMap.get("DISLIKECOUNT")).intValue();
			
			model.put("likeCount", likeCount);
			model.put("disLikeCount", disLikeCount);
   	    }
   	    
		// 작업 결과를 json으로 전송
		model.put("state", state);
		return model;
	}
	
	// 좋아요/싫어요 개수
	@RequestMapping(value="{board}/countReplyLike")
	@ResponseBody
	public Map<String, Object> countReplyLike(
			@PathVariable String board,
			@RequestParam Map<String, Object> paramMap) throws Exception {
		
		String state="true";
		int likeCount=0, disLikeCount=0;
		
		BoardManage bm=mservice.readBoardManage(board);
   	    if(bm==null) {
   	    	state="noTable";
   	    } else {
   	    	paramMap.put("tableName", bm.getBoard());

			Map<String, Object> result=service.replyLikeCount(paramMap);
			// resultType이 map인 경우 int는 BigDecimal로 넘어옴
			likeCount=((BigDecimal)result.get("LIKECOUNT")).intValue();
			disLikeCount=((BigDecimal)result.get("DISLIKECOUNT")).intValue();
   	    }
		
   	    Map<String, Object> model = new HashMap<>();
   	    model.put("state", state);
   	    model.put("likeCount", likeCount);
   	    model.put("disLikeCount", disLikeCount);
		
   	    // 작업 결과를 json으로 전송
   	    return model;
	}
}
