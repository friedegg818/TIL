package com.sp.admin.memberManage;

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

import com.sp.admin.security.AdminAuthenticator;
import com.sp.admin.security.AuthorizedValidException;
import com.sp.common.MyUtil;
import com.sp.member.Member;
import com.sp.member.MemberService;
import com.sp.member.SessionInfo;

@Controller("memberManage.memberManageController")
public class MemberManageController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/admin/memberManage/listMember")
	public String listMember(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="userId") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue="") String enabled,
			@RequestParam(defaultValue="") String membership,
			HttpServletRequest req, HttpSession session, 
			Model model) throws Exception {
		try {
			AdminAuthenticator.isAuthenticator(session);
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			
			String cp = req.getContextPath();
	   	    
			int rows = 10;
			int total_page = 0;
			int dataCount = 0;
	   	    
			if(req.getMethod().equalsIgnoreCase("GET")) {
				keyword = URLDecoder.decode(keyword, "utf-8");
			}
			
			// 전체 페이지 수
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("enabled", enabled);
	        map.put("membership", membership);
	        map.put("condition", condition);
	        map.put("keyword", keyword);
	        map.put("loginMembership", info.getMembership());

	        dataCount = memberService.dataCount(map);
	        if(dataCount != 0)
	            total_page = myUtil.pageCount(rows, dataCount) ;

	        if(total_page < current_page) 
	            current_page = total_page;

	        // 리스트에 출력할 데이터를 가져오기
	        int offset = (current_page-1) * rows;
			if(offset < 0) offset = 0;
	        map.put("offset", offset);
	        map.put("rows", rows);

	        List<Member> list = memberService.listMember(map);
			List<Member> listRole=memberService.listMemberRole();

	        // 리스트의 번호
	        int listNum, n = 0;
	        for(Member dto : list) {
	            listNum = dataCount - (offset + n);
	            dto.setListNum(listNum);
	            n++;
	        }
	        
	        String query = "";
	        String listUrl = cp+"/admin/memberManage/listMember";
	        
	        if(keyword.length()!=0) {
	        	query = "condition=" +condition + 
	        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
	        }
	        
	        if(enabled.length()!=0) {
	        	if(query.length()!=0)
	        		query = query +"&enabled="+enabled;
	        	else
	        		query = "enabled="+enabled;
	        }
	        if(membership.length()!=0) {
	        	if(query.length()!=0)
	        		query = query +"&membership="+membership;
	        	else
	        		query = "membership="+membership;
	        }
	        
	        if(query.length()!=0) {
	        	listUrl = listUrl + "?" + query;
	        }
	        
	        String paging = myUtil.paging(current_page, total_page, listUrl);        
			
	        model.addAttribute("list", list);
	        model.addAttribute("page", current_page);
	        model.addAttribute("dataCount", dataCount);
	        model.addAttribute("total_page", total_page);
	        model.addAttribute("paging", paging);
	        model.addAttribute("membership", membership);
	        model.addAttribute("enabled", enabled);
	        model.addAttribute("condition", condition);
	        model.addAttribute("keyword", keyword);
	        model.addAttribute("listRole", listRole);
	        
		} catch (AuthorizedValidException e) {
			return ".member.noAuthorized";
		}
		
		return ".admin.memberManage.listMember";
	}

	@RequestMapping(value="/admin/memberManage/detailedMember")
	public String detailedMember(
			@RequestParam String userId,
			Model model) throws Exception {
		
		Member dto=memberService.readMember2(userId);
		List<Member> listRole=memberService.listMemberRole();
		
		model.addAttribute("dto", dto);
		model.addAttribute("listRole", listRole);
		
		return "admin/memberManage/detailedMember";
	}	

	@RequestMapping(value="/admin/memberManage/updateMember", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateMember(
			Member dto) throws Exception {
		
		String state = "true";
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("memberIdx", dto.getMemberIdx());
			map.put("membership", dto.getMembership());
			map.put("enabled", dto.getEnabled());
			
			memberService.updateMembership(map);
			memberService.updateMemberEnabled(map);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}		
}
