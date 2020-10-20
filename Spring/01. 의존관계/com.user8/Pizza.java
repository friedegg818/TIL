package com.user8;

import java.util.concurrent.atomic.AtomicLong;

// AtomicLong : 동시성을 보장하며 자동으로 숫자를 증가 시킬 수 있는 클래스 
public class Pizza {
	private static AtomicLong count = new AtomicLong(0);	
	private boolean isVeg;
	
	public Pizza() {
		count.incrementAndGet();
	}
	
	@Override
	public String toString() {
		return "새로운 " + (isVeg ? "veggie" : "") + " Pizza, count(" + count.get() + ")";
	}
	
	public void setIsVeg(boolean veg) {
		this.isVeg = veg;
	}
}
