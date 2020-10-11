package test0203;

import java.util.Scanner;

public class IfEx2 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
	    int a,b,c;
		int tot;
		double ave;
		String name;
		
		System.out.print("이름?");
		name=sc.next();
		
		System.out.print("세과목 점수?");
		a=sc.nextInt();
		b=sc.nextInt();
		c=sc.nextInt();		
		
		tot=a+b+c;
		ave=(double)tot/3;
		
		if(a>=40 && b>=40 && c>=40 && ave>=60) {
			System.out.println(name+"님은 "+"합격 "+"입니다."); 
		} else if(ave<60) {
		   System.out.println(name+"님은 "+"불합격 "+"입니다.");
		} else { // (a<40 || b<40 \\ c<40) && ave>=60 
			System.out.println(name+"님은 "+"과락 "+"입니다.");
		}
		
		// 식이 간단해 질 수 있는 조건 찾기 
		
		sc.close();				
			
	}
}
