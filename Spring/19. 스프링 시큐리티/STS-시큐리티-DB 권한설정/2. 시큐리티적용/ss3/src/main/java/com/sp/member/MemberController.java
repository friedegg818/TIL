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

import com.sp.security.MyPasswordEncoder;

@Controller
public class MemberController {
	@Autowired
	private MemberService service;
	
	@Autowired
	private MyPasswordEncoder sha;
	
	// 변경 시작 부분 -----------------------------------------------------
	@RequestMapping(value="/member/login", method=RequestMethod.GET)
	public String loginForm(String login_error, Model model, HttpSession session) throws Exception {
		// 로그인 폼
		boolean bLoginError = login_error != null;
		
		String msg="";
		if(bLoginError) {
			msg="아이디 또는 패스워드를 잘못 입력 하셨습니다.";
			model.addAttribute("message", msg);
		}
		
		return ".member.login";
	}
	
	@RequestMapping(value="/member/noAuthorized")
	public String noAuthorized() {
		// 오서라이제이션(Authorization:권한)이 없는 경우
		
		return ".member.noAuthorized";
	}

	@RequestMapping(value="/member/expired")
	public String expired() {
		// 세션이 만료 된 경우
		
		return ".member.expired";
	}

	// 변경 끝 부분 -----------------------------------------------------
	
	// 회원가입 및 회원정보 수정 -----------------------
	@RequestMapping(value="/member/member", method=RequestMethod.GET)
	public String memberForm(Model model) {

		model.addAttribute("mode", "member");
		return ".member.member";
	}
	
	@RequestMapping(value="/member/member", method=RequestMethod.POST)
	public String memberSubmit(
			Member dto,
			final RedirectAttributes reAttr,
			Model model) throws Exception {
		
		// 패스워드 암호화
		String hashed=sha.encode(dto.getUserPwd());
		dto.setUserPwd(hashed);
		
		try {
			service.insertMember(dto);
		}catch(Exception e) {
			model.addAttribute("message", "회원가입이 실패했습니다. 다른 아이디로 다시 가입하시기 바랍니다.");
			model.addAttribute("mode", "member");
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
	
	@RequestMapping(value="/member/complete")
	public String complete(@ModelAttribute("message") String message) throws Exception{
		if(message==null || message.length()==0) { // F5를 누른 경우
			return "redirect:/";
		}
		
		return ".member.complete";
	}

	@RequestMapping(value="/member/pwd", method=RequestMethod.GET)
	public String pwdForm(
			String dropout,
			Model model,
			HttpSession session) {
		
		if(dropout==null) {
			model.addAttribute("mode", "update");
		} else {
			model.addAttribute("mode", "dropout");
		}
		
		return ".member.pwd";
	}
	
	@RequestMapping(value="/member/pwd", method=RequestMethod.POST)
	public String pwdSubmit(
			@RequestParam String userPwd,
			@RequestParam String mode,
			final RedirectAttributes reAttr,
			Model model,
			HttpSession session
	     ) {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Member dto=service.readMember2(info.getUserId());
		if(dto==null) {
			session.invalidate();
			return "redirect:/";
		}
		
		// 패스워드 비교(userPwd를 암호화 해서 dto.getUserPwd()와 비교하면 안된다.)
		//                 userPwd를 암호화하면 가입할때의 암호화 값과 다름. 암호화할때 마다 다른 값
		boolean bPassword = sha.matches(userPwd, dto.getUserPwd());
		
		if(! bPassword) {
			if(mode.equals("update")) {
				model.addAttribute("mode", "update");
			} else {
				model.addAttribute("mode", "dropout");
			}
			model.addAttribute("message", "패스워드가 일치하지 않습니다.");
			return ".member.pwd";
		}
		
		if(mode.equals("dropout")){
			// 회원탈퇴 처리
			
			
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

	@RequestMapping(value="/member/update",
			method=RequestMethod.POST)
	public String updateSubmit(
			Member dto,
			final RedirectAttributes reAttr,
			HttpSession session) throws Exception {
		
		try {
			// 패스워드 암호화
			String hashed=sha.encode(dto.getUserPwd());
			dto.setUserPwd(hashed);
			
			service.updateMember2(dto);
		} catch (Exception e) {
		}
		
		StringBuilder sb=new StringBuilder();
		sb.append(dto.getUserName()+ "님의 회원정보가 정상적으로 변경되었습니다.<br>");
		sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		
		reAttr.addFlashAttribute("title", "회원 정보 수정");
		reAttr.addFlashAttribute("message", sb.toString());
		
		return "redirect:/member/complete";
	}
	
	@RequestMapping(value="/member/userIdCheck")
	@ResponseBody
	public Map<String, Object> userIdCheck(
			@RequestParam String userId
			) throws Exception {
		String passed="false";
		Member dto=service.readMember2(userId);
		if(dto==null)
			passed="true";
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("passed", passed);
		return model;
	}
}
