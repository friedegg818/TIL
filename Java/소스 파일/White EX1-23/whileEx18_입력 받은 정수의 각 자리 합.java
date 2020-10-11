package test0203;

import java.util.Scanner;

public class whileEx18 {
	public static void main(String[] args) {
		// 정수를 입력 받아 입력 받은 숫자의 각 자리의 합을 구하기 
		Scanner sc=new Scanner(System.in);
		int n, s;
		n=0; // 초기화. but 꼭 주지 않아도 됨. 대신 주려면 입력 전에 줘야 함 
		s=0;
		
		System.out.print("숫자를 입력하세요."); 
		n=sc.nextInt();
			
		while (n!=0) {
			s += n%10; // s에 n을 10으로 나눈 나머지를 더하기 
			           // 어떤 숫자를 10으로 나누면 맨 끝자리 수가 나옴
		System.out.printf("sum=%3d num=%d%n", s,n);
		               // %3d > 정수를 3자리로 표현 
		
		n /= 10; // n을 10으로 나눈 몫을 다시 n에 부여  
		         // (=마지막 자리 수 떼고 남은 수) 
	}
		System.out.println("각 자리수의 합:"+s);
		
		sc.close();		
	}
}
