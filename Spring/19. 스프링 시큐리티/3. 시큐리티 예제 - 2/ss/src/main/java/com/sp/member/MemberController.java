package com.sp.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("member.memberController")
@RequestMapping("/member/*")
public class MemberController {
	@Autowired
	private MemberService service;
	
	// login 폼은 GET으로 처리하며,
	// login 실패시 loginFailureHandler 에서 /member/login 으로 설정
	//     하여 POST로 다시 이 주소로 이동하므로 GET과 POST를 모두 처리하도록 주소를 매핑
	@RequestMapping(value="login")
	public String loginForm() throws Exception {
		return ".member.login";
	}
	
	@RequestMapping(value="noAuthorized")
	public String noAuthorized() throws Exception {
		// 접근 오서라이제이션(Authorization:권한)이 없는 경우
		
		return ".member.noAuthorized";
	}
	
	@RequestMapping(value="expired")
	public String expired() throws Exception {
		// 세션이 익스파이어드(만료) 된 경우
		
		return ".member.expired";
	}
	
	// 회원가입 및 회원정보 수정 -----------------------
	@RequestMapping(value="member", method=RequestMethod.GET)
	public String memberForm(Model model) throws Exception {
		model.addAttribute("mode", "member");
		return ".member.member";
	}

	@RequestMapping(value="member", method=RequestMethod.POST)
	public String memberSubmit(Member dto,
			final RedirectAttributes reAttr,
			Model model) throws Exception {

		try {
			service.insertMember(dto);
		}catch(Exception e) {
			model.addAttribute("message", "회원가입이 실패했습니다. 다른 아이디로 다시 가입하시기 바랍니다.");
			model.addAttribute("mode", "created");
			return ".member.member";
		}
		
		StringBuilder sb=new StringBuilder();
		sb.append(dto.getUserName()+ "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
		sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");
		
		 // 리다이렉트된 페이지에 값 넘기기
        reAttr.addFlashAttribute("message", sb.toString());
        reAttr.addFlashAttribute("title", "회원 가입");
		
		return "redirect:/member/complete";
	}
	
	@RequestMapping(value="complete")
	public String complete(@ModelAttribute("message") String message) throws Exception{
		
		if(message==null || message.length()==0) { // F5를 누른 경우
			return "redirect:/";
		}
		
		return ".member.complete";
	}
	
	@RequestMapping(value="pwd", method=RequestMethod.GET)
	public String pwdForm(
			String dropout,
			Model model) throws Exception {
		
		if(dropout==null) {
			model.addAttribute("mode", "update");
		} else {
			model.addAttribute("mode", "dropout");
		}
		
		return ".member.pwd";
	}
	
	@RequestMapping(value="pwd", method=RequestMethod.POST)
	public String pwdSubmit(
			@RequestParam String userPwd,
			@RequestParam String mode,
			final RedirectAttributes reAttr,
			Model model,
			HttpSession session) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		boolean bPwd = service.isPasswordCheck(info.getUserId(), userPwd);
		if(! bPwd) {
			if(mode.equals("update")) {
				model.addAttribute("mode", "update");
			} else {
				model.addAttribute("mode", "dropout");
			}
			model.addAttribute("message", "패스워드가 일치하지 않습니다.");
			return ".member.pwd";
		}
		
		Member dto = service.readMember(info.getUserId());
		if(mode.equals("dropout")){

			// 세션 정보 삭제
			session.removeAttribute("member");
			session.invalidate();

			StringBuilder sb=new StringBuilder();
			sb.append(dto.getUserName()+ "님의 회원 탈퇴 처리가 정상적으로 처리되었습니다.<br>");
			sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
			
			reAttr.addFlashAttribute("title", "회원 탈퇴");
			reAttr.addFlashAttribute("message", sb.toString());
			
			return "redirect:/member/complete";
		}

		// 회원정보수정폼
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		return ".member.member";
	}

	@RequestMapping(value="updatePwd", method=RequestMethod.GET)
	public String updatePwdForm() throws Exception{
		return ".member.updatePwd";
	}

	@RequestMapping(value="updatePwd", method=RequestMethod.POST)
	public String updatePwdSubmit(
			@RequestParam String userPwd,
			HttpSession session) throws Exception{
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Member dto = new Member();
		dto.setUserId(info.getUserId());
		dto.setUserPwd(userPwd);
		
		try {
			service.updatePwd(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Member dto,
			final RedirectAttributes reAttr,
			Model model) throws Exception {
		
		try {
			service.updateMember(dto);
		} catch (Exception e) {
		}
		
		StringBuilder sb=new StringBuilder();
		sb.append(dto.getUserName()+ "님의 회원정보가 정상적으로 변경되었습니다.<br>");
		sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		
		reAttr.addFlashAttribute("title", "회원 정보 수정");
		reAttr.addFlashAttribute("message", sb.toString());
		
		return "redirect:/member/complete";
	}

	@RequestMapping(value="userIdCheck", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> idCheck(
			@RequestParam String userId) throws Exception {
		
		String p="true";
		Member dto=service.readMember(userId);
		if(dto!=null) {
			p="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("passed", p);
		return model;
	}
	
	@RequestMapping(value="pwdFind", method=RequestMethod.GET)
	public String pwdFindForm(HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info!=null) {
			return "redirect:/";
		}
		
		return ".member.pwdFind";
	}
	
	@RequestMapping(value="pwdFind", method=RequestMethod.POST)
	public String pwdFindSubmit(@RequestParam String userId,
			final RedirectAttributes reAttr,
			Model model
			) throws Exception {
		
		Member dto = service.readMember(userId);
		if(dto==null || dto.getEmail()==null || dto.getEnabled()==0) {
			model.addAttribute("message", "등록된 아이디가 아닙니다.");
			return ".member.pwdFind";
		}
		
		try {
			service.generatePwd(dto);
		} catch (Exception e) {
			model.addAttribute("message", "이메일 전송이 실패했습니다.");
			return ".member.pwdFind";
		}
		
		StringBuilder sb=new StringBuilder();
		sb.append("회원님의 이메일로 임시패스워드를 전송했습니다.<br>");
		sb.append("로그인 후 패스워드를 변경하시기 바랍니다.<br>");
		
		reAttr.addFlashAttribute("title", "패스워드 찾기");
		reAttr.addFlashAttribute("message", sb.toString());
		
		return "redirect:/member/complete";
	}
	
}
