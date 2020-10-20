package com.sp.guest.xml;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="record")
@XmlAccessorType(XmlAccessType.NONE)
public class GuestElement {	
	@XmlAttribute
	private int num;
	@XmlElement
	private String name;
	@XmlElement
	private String content;
	@XmlElement
	private String created;
	
	public GuestElement() {
	}
	
	public GuestElement(int num, String name, String content, String created) {
		this.num = num;
		this.name = name;
		this.content = content;
		this.created = created;
	}	
}
