package com.sp.insa2;

public interface InsaService {
	public int tax(int sal, int bonus);
	public int pay(int sal, int bonus, int tax);
	public int age(String birth);
	public String ani(String birth);

}
