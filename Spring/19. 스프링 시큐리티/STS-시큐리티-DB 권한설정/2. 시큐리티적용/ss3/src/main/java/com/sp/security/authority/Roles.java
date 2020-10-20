package com.sp.security.authority;

public class Roles {
	private int listNum;
	private String authority;
	private String role_name;
	private String description;
	private String created_date;
	private String modify_date;
	
	private String oldAuthority;
	
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getRole_name() {
		return role_name;
	}
	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCreated_date() {
		return created_date;
	}
	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}
	public String getModify_date() {
		return modify_date;
	}
	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}
	public String getOldAuthority() {
		return oldAuthority;
	}
	public void setOldAuthority(String oldAuthority) {
		this.oldAuthority = oldAuthority;
	}
}
