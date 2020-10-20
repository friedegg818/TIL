package com.sp.member;

import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;
import com.sp.mail.Mail;
import com.sp.mail.MailSender;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private CommonDAO  dao;

	@Autowired
	private MailSender mailSender;
	
	@Autowired
	private BCryptPasswordEncoder bcryptEncoder;
	
	@Override
	public Member loginMember(String userId) {
		Member dto=null;
		
		try {
			dto=dao.selectOne("member.loginMember", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public void insertMember(Member dto) throws Exception {
		try {
			// 패스워드 암호화
			String encPassword = bcryptEncoder.encode(dto.getUserPwd());
			dto.setUserPwd(encPassword);
			
			if(dto.getEmail1() != null && dto.getEmail1().length()!=0 &&
					dto.getEmail2() != null && dto.getEmail2().length()!=0)
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			
			if(dto.getTel1() != null && dto.getTel1().length()!=0 &&
					dto.getTel2() != null && dto.getTel2().length()!=0 &&
							dto.getTel3() != null && dto.getTel3().length()!=0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			
			long memberSeq = dao.selectOne("member.memberSeq");
			dto.setMemberIdx(memberSeq);
			
			// 회원정보 저장
			dao.insertData("member.insertMember", memberSeq);
			
			// dao.insertData("member.insertMember1", dto);
			// dao.insertData("member.insertMember2", dto);
			dao.updateData("member.insertMember12", dto); // member1, member2 테이블 동시에 
			
			// 권한저장
			dto.setAuthority("ROLE_USER");
			dao.insertData("member.insertAuthority", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public Member readMember(String userId) {
		Member dto=null;
		
		try {
			dto=dao.selectOne("member.readMember", userId);
			
			if(dto!=null) {
				if(dto.getEmail()!=null) {
					String [] s=dto.getEmail().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
				}

				if(dto.getTel()!=null) {
					String [] s=dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public Member readMember(long memberIdx) {
		Member dto=null;
		
		try {
			dto=dao.selectOne("member.readMember2", memberIdx);
			
			if(dto!=null) {
				if(dto.getEmail()!=null) {
					String [] s=dto.getEmail().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
				}

				if(dto.getTel()!=null) {
					String [] s=dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public boolean isPasswordCheck(String userId, String userPwd) {
		Member dto = readMember(userId);
		if(dto==null) {
			return false;
		}
		
		// 패스워드 비교(userPwd를 암호화 해서 dto.getUserPwd()와 비교하면 안된다.)
		//                 userPwd를 암호화하면 가입할때의 암호화 값과 다름. 암호화할때 마다 다른 값
		
		return bcryptEncoder.matches(userPwd, dto.getUserPwd());
	}
	
	@Override
	public void updateMembership(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("member.updateMembership", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updateLastLogin(String userId) throws Exception {
		try {
			dao.updateData("member.updateLastLogin", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updateMember(Member dto) throws Exception {
		try {
			if(dto.getEmail1() != null && dto.getEmail1().length()!=0 &&
					dto.getEmail2() != null && dto.getEmail2().length()!=0)
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			
			if(dto.getTel1() != null && dto.getTel1().length()!=0 &&
					dto.getTel2() != null && dto.getTel2().length()!=0 &&
							dto.getTel3() != null && dto.getTel3().length()!=0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			
			boolean bPwdUpdate = ! isPasswordCheck(dto.getUserId(), dto.getUserPwd());
			if(bPwdUpdate) {
				// 패스워드가 변경된 경우만 패스워드 변경
				String encPassword = bcryptEncoder.encode(dto.getUserPwd());
				dto.setUserPwd(encPassword);
				
				dao.updateData("member.updateMember1", dto);
			}
			dao.updateData("member.updateMember2", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updatePwd(Member dto) throws Exception {
		try {
			String encPassword = bcryptEncoder.encode(dto.getUserPwd());
			dto.setUserPwd(encPassword);
			
			dao.updateData("member.updateMember1", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		try {
			map.put("membershep", 0);
			updateMembership(map);
			
			dao.deleteData("member.deleteMember2", map);
			dao.deleteData("member.deleteMember1", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void generatePwd(Member dto) throws Exception {
		// 10 자리 임시 패스워드 생성
		StringBuilder sb = new StringBuilder();
		Random rd = new Random();
		String s="!@#$%^&*~-+ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
		for(int i=0; i<10; i++) {
			int n = rd.nextInt(s.length());
			sb.append(s.substring(n, n+1));
		}
		
		String result;
		result = dto.getUserId()+"님의 새로 발급된 임시 패스워드는 <b>"
		         + sb.toString()+"</b> 입니다.<br>"
		         + "로그인 후 반드시 패스워드를 변경 하시기 바랍니다.";
		
		Mail mail = new Mail();
		mail.setReceiverEmail(dto.getEmail());
		
		mail.setSenderEmail("보내는사람이메일@도메인");
		mail.setSenderName("관리자");
		mail.setSubject("임시 패스워드 발급");
		mail.setContent(result);
		
		boolean b = mailSender.mailSend(mail);
		
		if(b) {
			updatePwd(dto);
		} else {
			throw new Exception("이메일 전송중 오류가 발생했습니다.");
		}
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("member.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Member> listMember(Map<String, Object> map) {
		List<Member> list=null;
		try {
			list=dao.selectList("member.listMember", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateAuthority(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("member.updateAuthority", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Member> listAuthority(String userId) {
		List<Member> list=null;
		try {
			list=dao.selectList("member.listAuthority", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int checkFailureCount(String userId) {
		int result = 0;
		try {
			result = dao.selectOne("member.checkFailureCount", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void updateFailureCount(String userId) throws Exception {
		try {
			dao.updateData("member.updateFailureCount", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateFailureCountReset(String userId) throws Exception {
		try {
			dao.updateData("member.updateFailureCountReset", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updateMemberEnabled(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("member.updateMemberEnabled", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertMemberState(Member dto) throws Exception {
		try {
			dao.updateData("member.insertMemberState", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Member> listMemberState(String userId) {
		List<Member> list=null;
		try {
			list=dao.selectList("member.listMemberState", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Member readMemberState(String userId) {
		Member dto=null;
		
		try {
			dto=dao.selectOne("member.readMemberState", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

}
