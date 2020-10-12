package test0206;

import java.util.Scanner;

public class BreakEx1 {

	public static void main(String[] args) {
		// 정수를 입력 받아 입력 받은 수의 합 구하기
		// 단, 입력 받은 수가 0이면 프로그램 종료 
		Scanner sc=new Scanner(System.in);
		int n,s;
		
		s=0;
		System.out.print("정수입력[종료 : 0]?");
		while(true) {
			n=sc.nextInt(); // 숫자를 계속적으로 입력 
			if(n==0) break; // 0을 누르면 숫자 입력+밑의 실행문 종료 
			
			s+=n;
		}
		
		System.out.println("결과 : "+s);
		
		sc.close();
	}
}
