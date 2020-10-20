package com.user4;

public class User {
	private String addr;
	private String zip;
	
	public User() {
	}
	
	public User(String addr, String zip) {
		this.addr = addr;
		this.zip = zip;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	@Override
	public String toString() {		
		return zip + ", " + addr;
	}	
}
