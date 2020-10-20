package com.sp.blog;

public class Blog {
	private Long userIdx;
	private String userName;
	private String title;
	private String blogGroup;
	
	public Blog() {	
	}
	
	public Blog(Long userIdx, String userName, String title, String blogGroup) {
		this.userIdx = userIdx;
		this.userName = userName;
		this.title = title;
		this.blogGroup = blogGroup;
	}
	
	public Long getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(Long userIdx) {
		this.userIdx = userIdx;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBlogGroup() {
		return blogGroup;
	}
	public void setBlogGroup(String blogGroup) {
		this.blogGroup = blogGroup;
	}	
}
