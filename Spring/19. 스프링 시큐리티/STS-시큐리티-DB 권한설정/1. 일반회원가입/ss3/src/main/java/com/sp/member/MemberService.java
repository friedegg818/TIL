package com.sp.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	public Member readMember1(long memberIdx);
	public Member readMember2(String userId);
	
	public void insertMember(Member dto) throws Exception;
	
	public void updateMember2(Member dto) throws Exception;
	public void updateLastLogin(String userId) throws Exception;
	public void updateEnabled(Map<String, Object> map) throws Exception;
	
	public void deleteMember2(Map<String, Object> map) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Member> listMember(Map<String, Object> map);
	
	public void insertAuthoritiesMember(Member dto) throws Exception;
	public void updateAuthoritiesMember(Member dto) throws Exception;
	public List<Member> listAuthoritiesMember(String userId);
	public void deleteAuthoritiesMember(Map<String, Object> map) throws Exception;
}
