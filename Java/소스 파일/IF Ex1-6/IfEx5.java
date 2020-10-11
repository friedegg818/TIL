package test0131;

import java.util.Scanner;

public class IfEx5 {
	public static void main(String[] args) {
		// 세 수를 입력 받아 적은수에서 큰수 순으로 출력(정렬의 기초) 
		Scanner sc=new Scanner(System.in);
		int a,b,c, t;
		
		System.out.print("세 수?");
		a=sc.nextInt();
		b=sc.nextInt();
		c=sc.nextInt();
		
		if(a > b) {
			t=a; a=b; b=t;
		}
			// 실행하고 나면 a<b		
		if(a > c) {
			t=a; a=c; c=t;
		}
		    // 실행하고 나면 a<c -> a는 가장 작은 값 
		if(b > c) {
			t=b; b=c; c=t;
		}
		   // 실행하고 나면 b<c -> a<b<c가 됨. 
		
		System.out.println(a+","+b+","+c);		
		
		sc.close();		
	}
}
