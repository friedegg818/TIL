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

import com.sp.common.MyUtil;
import com.sp.member.Member;
import com.sp.member.MemberService;
import com.sp.security.authority.Roles;
import com.sp.security.authority.RolesService;

@Controller("memberManage.memberManageController")
public class MemberManageController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private RolesService rolesService;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/admin/memberManage/info")
	public String info(HttpSession session, Model model) throws Exception {
		
		model.addAttribute("subMenu", "1");
		return ".admin4.menu1.memberManage.info";
	}

	@RequestMapping(value="/admin/memberManage/member")
	public String memberManage(@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="userId") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue="") String enabled,
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
        map.put("enabled", enabled);
        map.put("condition", condition);
        map.put("keyword", keyword);

        dataCount = memberService.dataCount(map);
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

        // 멤버 리스트
        List<Member> list = memberService.listMember(map);

        // 리스트의 번호
        int listNum, n = 0;
        for(Member dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/admin/memberManage/member";
        
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
        
        if(query.length()!=0) {
        	listUrl = listUrl + "?" + query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);        
		
        model.addAttribute("subMenu", "2");
        
        model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        model.addAttribute("enabled", enabled);
        model.addAttribute("condition", condition);
        model.addAttribute("keyword", keyword);
        
		return ".admin4.menu1.memberManage.member";
	}
	
	@RequestMapping(value="/admin/memberManage/detailedMember", method=RequestMethod.POST)
	public String detailedMember(
			@RequestParam String userId,
			Model model) throws Exception {
		
		Member dto=memberService.readMember2(userId);
		List<Roles> listRoles=rolesService.listRoles();
		
		for(int idx=0; idx<listRoles.size(); idx++) {
			Roles vo=listRoles.get(idx);
			if(vo.getAuthority().equals("ROLE_ADMIN")) {
				listRoles.remove(vo);
				break;
			}
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("listRoles", listRoles);
		
		return "admin/menu1/memberManage/detailedMember";
	}	

	@RequestMapping(value="/admin/memberManage/updateMember", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateMember(
			Member dto) throws Exception {
		
		String state = "true";
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("userId", dto.getUserId());
			map.put("enabled", dto.getEnabled());
			memberService.updateEnabled(map);
			
			memberService.updateAuthoritiesMember(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}	
}

