package test0204_forquiz;

import java.util.Scanner;

public class quiz5 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int n;
		int max;
		
		max=0; 
		System.out.print("5개의 정수를 입력 하세요...");
		for(int i=1; i<=5; i++) {
			n=sc.nextInt();   
			if(i==1) { // 처음 입력 받은 수를 max의 초기값으로 
				max=n; 
			} else if(max<n) { // 그 후로는 초기값과 입력받은 값을 비교
				max=n;
			}
		}
		System.out.println("최대값:"+max);
		
		sc.close();
	}
}
