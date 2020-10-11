package test0203;

import java.util.Scanner;

public class whileEx16 {
	public static void main(String[] args) {
		//정수를 입력 받아 1부터 입력 받은 수까지 홀수 합 구하기 
		Scanner sc=new Scanner(System.in);
		int num;
		int n, s;
		
		System.out.print("정수?");
		num=sc.nextInt();
		
		n=1;
		s=0;
		
		while (n<=num) {   
			s+=n; 
			n+=2;			 
		}
		System.out.println("결과:"+s);
			
		sc.close();		
	}
}
