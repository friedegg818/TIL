package com.sp.insa2;

import java.util.Calendar;

import org.springframework.stereotype.Service;

@Service("insa2.insaService")
public class InsaServiceImpl implements InsaService {

	@Override
	public int tax(int sal, int bonus) {
		int sum = sal + bonus;
		int tax = 0;
		
		if(sum >= 3000000) {
			tax = (int) (sum * 0.03);
		} else if (sum >= 2000000) {
			tax = (int) (sum * 0.02);
		} else {
			tax = 0;
		}
		
		return tax;
	}

	@Override
	public int pay(int sal, int bonus, int tax) {
	
		int pay = sal + bonus - tax;
		
		return pay;
	}

	@Override
	public int age(String birth) {
	  String str = birth.replaceAll("(\\.|\\/|\\-)", "");  
		
	  int y=Integer.parseInt(str.substring(0, 4));
	  int m=Integer.parseInt(str.substring(4, 6));
	  int d=Integer.parseInt(str.substring(6, 8));   

	  Calendar cal=Calendar.getInstance();
	  cal.set(Calendar.YEAR, y);
	  cal.set(Calendar.MONTH, m-1);
	  cal.set(Calendar.DATE, d);
		    
	  Calendar now = Calendar.getInstance ();
		    
	  int age = now.get(Calendar.YEAR) - cal.get(Calendar.YEAR);
	  if ( (cal.get(Calendar.MONTH) > now.get(Calendar.MONTH))
	        || (cal.get(Calendar.MONTH) == now.get(Calendar.MONTH) 
	           && cal.get(Calendar.DAY_OF_MONTH) > now.get(Calendar.DAY_OF_MONTH))) {
	       age--;
	    }
	  
		return age;
	}

	@Override
	public String ani(String birth) {
	  String str = birth.replaceAll("(\\.|\\/|\\-)", "");  
			
	  int y=Integer.parseInt(str.substring(0, 4));
		
	  String []tt={"원숭이", "닭","개","돼지","쥐","소","호랑이","토끼","용","뱀","말","양"};
	  int idx=y%12;
	  String ani=tt[idx];
		
	  return ani;
	}

}
