package com.sp.member;

// 세션에 저장할 정보(아이디, 이름, 권한등)
public class SessionInfo {
	private long memberIdx;
	private String userId;
	private String userName;
	private int membership; // 역할(비회원:0, 일반회원:1, 사원:50, 준관리자:90, 관리자:99)

	public long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(long memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getMembership() {
		return membership;
	}
	public void setMembership(int membership) {
		this.membership = membership;
	}
}
