package com.sp.admin.boardManage;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.admin.security.AdminAuthenticator;
import com.sp.admin.security.AuthorizedValidException;
import com.sp.admin.security.LoginValidException;
import com.sp.member.Member;

@Controller("boardManage.boardManageController")
public class BoardManageController {
	@Autowired
	private BoardManageService service;
	
	@RequestMapping(value="/admin/boardManage/list")
	public String list(HttpSession session, Model model) throws Exception {
		try {
			AdminAuthenticator.isAuthenticator(session);
			
			int dataCount = 0;
	        dataCount = service.dataCount();
	        List<BoardManage> list = service.listBoardManage();
	        List<Member> listRole=service.listMemberRole();
	        
	        for(BoardManage bm:list) {
	        	for(Member m:listRole) {
	        		if(bm.getUpdateMembership()==m.getMembership()) {
	        			bm.setUpdateMembershipName(m.getMemberRole());
	        		}
	        		
	        		if(bm.getAnswerMembership()==m.getMembership()) {
	        			bm.setAnswerMembershipName(m.getMemberRole());
	        		}
	        	}
	        }

			model.addAttribute("dataCount", dataCount);
			model.addAttribute("list", list);
			model.addAttribute("listRole", listRole);
			
		} catch (LoginValidException e) {
			return ".member.login";
		} catch (AuthorizedValidException e) {
			return ".member.noAuthorized";
		}
		
		return ".admin.boardManage.list";
	}
	
	@RequestMapping(value="/admin/boardManage/created", method=RequestMethod.GET)
	public String createdForm(HttpSession session, Model model) throws Exception {
		try {
			AdminAuthenticator.isAuthenticator(session);
			
	        List<Member> listRole=service.listMemberRole();
			
			model.addAttribute("mode", "created");
			model.addAttribute("listRole", listRole);
			
		} catch (LoginValidException e) {
			return ".member.login";
		} catch (AuthorizedValidException e) {
			return ".member.noAuthorized";
		}
		
		return ".admin.boardManage.created";
	}
	
	@RequestMapping(value="/admin/boardManage/created", method=RequestMethod.POST)
	public String createdSubmit(HttpSession session, 
			                      BoardManage dto, Model model) throws Exception {
		try {
			AdminAuthenticator.isAuthenticator(session);
			
			dto.setBoard(dto.getBoard());
			
			service.createBoardManage(dto);
		} catch (LoginValidException e) {
			return ".member.login";
		} catch (AuthorizedValidException e) {
			return ".member.noAuthorized";
		} catch (Exception e) {
			String msg="게시판 주소 중복등으로 게시판 작성이 실패 했습니다. !!!";
			
			List<Member> listRole=service.listMemberRole();
			
			model.addAttribute("mode", "created");
			model.addAttribute("message", msg);
			model.addAttribute("listRole", listRole);
			
			return ".admin.boardManage.created";
		}
		
		return "redirect:/admin/boardManage/list";
	}

	@RequestMapping(value="/admin/boardManage/update", method=RequestMethod.GET)
	public String updateForm(HttpSession session, 
			                 @RequestParam int num,
			                 Model model) throws Exception {
		try {
			AdminAuthenticator.isAuthenticator(session);
			
			BoardManage dto=service.readBoardManage(num);
			if(dto==null) {
				return "redirect:/admin/boardManage/list";
			}
			
	        List<Member> listRole=service.listMemberRole();
			
			model.addAttribute("mode", "update");
			model.addAttribute("dto", dto);
			model.addAttribute("listRole", listRole);
			
		} catch (LoginValidException e) {
			return ".member.login";
		} catch (AuthorizedValidException e) {
			return ".member.noAuthorized";
		}
		
		return ".admin.boardManage.created";
	}
	
	@RequestMapping(value="/admin/boardManage/update", method=RequestMethod.POST)
	public String updateSubmit(HttpSession session, BoardManage dto) throws Exception {
		try {
			AdminAuthenticator.isAuthenticator(session);
			
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+File.separator+"uploads"+File.separator+"cboard";
			
			service.updateBoardManage(dto, pathname);
			
		} catch (LoginValidException e) {
			return ".member.login";
		} catch (AuthorizedValidException e) {
			return ".member.noAuthorized";
		} catch (Exception e) {
		}
		
		return "redirect:/admin/boardManage/list";
	}
	
	@RequestMapping(value="/admin/boardManage/delete")
	public String deleteSubmit(HttpSession session, @RequestParam int num) throws Exception {
		try {
			AdminAuthenticator.isAuthenticator(session);
			
			String root=session.getServletContext().getRealPath("/");
			String pathname=root+File.separator+"uploads"+File.separator+"cboard";
			service.deleteBoardManage(num, pathname);
			
		} catch (LoginValidException e) {
			return ".member.login";
		} catch (AuthorizedValidException e) {
			return ".member.noAuthorized";
		} catch (Exception e) {
		}
		
		return "redirect:/admin/boardManage/list";
	}
}
