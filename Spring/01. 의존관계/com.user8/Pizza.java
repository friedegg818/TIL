package com.user8;

import java.util.concurrent.atomic.AtomicLong;

// AtomicLong : ���ü��� �����ϸ� �ڵ����� ���ڸ� ���� ��ų �� �ִ� Ŭ���� 
public class Pizza {
	private static AtomicLong count = new AtomicLong(0);	
	private boolean isVeg;
	
	public Pizza() {
		count.incrementAndGet();
	}
	
	@Override
	public String toString() {
		return "���ο� " + (isVeg ? "veggie" : "") + " Pizza, count(" + count.get() + ")";
	}
	
	public void setIsVeg(boolean veg) {
		this.isVeg = veg;
	}
}
