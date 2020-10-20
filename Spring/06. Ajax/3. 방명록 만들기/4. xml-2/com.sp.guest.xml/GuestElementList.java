package com.sp.guest.xml;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="root")
public class GuestElementList {
	private List<GuestElement> record = new ArrayList<GuestElement>();
	private int dataCount;
	private String pageNo;
	private String paging;
	
	public List<GuestElement> getRecord() {
		return record;
	}
	public void setRecord(List<GuestElement> record) {
		this.record = record;
	}
	public int getDataCount() {
		return dataCount;
	}
	public void setDataCount(int dataCount) {
		this.dataCount = dataCount;
	}
	public String getPageNo() {
		return pageNo;
	}
	public void setPageNo(String pageNo) {
		this.pageNo = pageNo;
	}
	public String getPaging() {
		return paging;
	}
	public void setPaging(String paging) {
		this.paging = paging;
	}	
}
