package com.sp.member;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private CommonDAO  dao;

	@Override
	public Member readMember1(long memberIdx) {
		Member dto=null;
		try {
			dto=dao.selectOne("member.readMember1", memberIdx);
			
			if(dto!=null) {
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
	public Member readMember2(String userId) {
		Member dto=null;
		try {
			dto=dao.selectOne("member.readMember2", userId);
			
			if(dto!=null) {
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
	public void insertMember(Member dto) throws Exception{
		try {
			if(dto.getTel1() != null && dto.getTel1().length()!=0 &&
					dto.getTel2() != null && dto.getTel2().length()!=0 &&
							dto.getTel3() != null && dto.getTel3().length()!=0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());

			long seq=dao.selectOne("member.memberSeq");
			dto.setMemberIdx(seq);
			
			// 회원정보 저장
			dao.insertData("member.insertMember1", seq);
			dao.insertData("member.insertMember2", dto);
			
			// 권한저장
			dto.setAuthority("ROLE_MBER");
			insertAuthoritiesMember(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updateMember2(Member dto) throws Exception{
		try {
			if(dto.getTel1() != null && dto.getTel1().length()!=0 &&
					dto.getTel2() != null && dto.getTel2().length()!=0 &&
							dto.getTel3() != null && dto.getTel3().length()!=0)
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			
			dao.updateData("member.updateMember2", dto);
			
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
	public void updateEnabled(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("member.updateEnabled", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void deleteMember2(Map<String, Object> map) throws Exception{
		try {
			// member1 테이블 수정
			long memberIdx=(Long)map.get("memberIdx");
			dao.updateData("member.updateMember1", memberIdx);
			
			// member2 테이블 삭제
			String userId=(String)map.get("userId");
			dao.deleteData("member.deleteMember2", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
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
	public void insertAuthoritiesMember(Member dto) throws Exception {
		try {
			dao.insertData("member.insertAuthoritiesMember", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateAuthoritiesMember(Member dto) throws Exception {
		try {
			dao.updateData("member.updateAuthoritiesMember", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Member> listAuthoritiesMember(String userId) {
		List<Member> list=null;
		try {
			list=dao.selectList("member.listAuthoritiesMember", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void deleteAuthoritiesMember(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("member.deleteAuthoritiesMember", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
