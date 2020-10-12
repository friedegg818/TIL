package test0204_forquiz;

import java.util.Scanner;

public class quiz5_1 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int n;
		int max;
		
		max=Integer.MIN_VALUE; // 가장 적은 값을 초기값으로
		System.out.println("5개 정수 입력...");
		for(int i=1; i<=5; i++) {
			n=sc.nextInt();
			if(max<n) {
				max=n;
			}
		}
		System.out.println("최대값:"+max);
		
		sc.close();
	}
}
