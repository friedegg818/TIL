package test0204_forquiz;

import java.util.Scanner;

public class quiz5_1 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int n;
		int max;
		
		max=Integer.MIN_VALUE; // ���� ���� ���� �ʱⰪ����
		System.out.println("5�� ���� �Է�...");
		for(int i=1; i<=5; i++) {
			n=sc.nextInt();
			if(max<n) {
				max=n;
			}
		}
		System.out.println("�ִ밪:"+max);
		
		sc.close();
	}
}
