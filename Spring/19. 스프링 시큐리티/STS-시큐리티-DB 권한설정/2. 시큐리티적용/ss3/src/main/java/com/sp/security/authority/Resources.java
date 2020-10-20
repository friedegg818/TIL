package com.sp.security.authority;

public class Resources {
	private int listNum;
	
	private int resource_id;
    private String resource_name;
    private String resource_pattern;
    private String resource_type;
    private String description;
    private int sort_order;
    private String created_date;
    private String modify_date;
	
    private String authority;
    
	private int oldResource_id;
    private String oldAuthority;
    
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getResource_id() {
		return resource_id;
	}
	public void setResource_id(int resource_id) {
		this.resource_id = resource_id;
	}
	public String getResource_name() {
		return resource_name;
	}
	public void setResource_name(String resource_name) {
		this.resource_name = resource_name;
	}
	public String getResource_pattern() {
		return resource_pattern;
	}
	public void setResource_pattern(String resource_pattern) {
		this.resource_pattern = resource_pattern;
	}
	public String getResource_type() {
		return resource_type;
	}
	public void setResource_type(String resource_type) {
		this.resource_type = resource_type;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getSort_order() {
		return sort_order;
	}
	public void setSort_order(int sort_order) {
		this.sort_order = sort_order;
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
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public int getOldResource_id() {
		return oldResource_id;
	}
	public void setOldResource_id(int oldResource_id) {
		this.oldResource_id = oldResource_id;
	}
	public String getOldAuthority() {
		return oldAuthority;
	}
	public void setOldAuthority(String oldAuthority) {
		this.oldAuthority = oldAuthority;
	}
}
