package test0204_forquiz;

import java.util.Scanner;

public class quiz5 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int n;
		int max;
		
		max=0; 
		System.out.print("5���� ������ �Է� �ϼ���...");
		for(int i=1; i<=5; i++) {
			n=sc.nextInt();   
			if(i==1) { // ó�� �Է� ���� ���� max�� �ʱⰪ���� 
				max=n; 
			} else if(max<n) { // �� �ķδ� �ʱⰪ�� �Է¹��� ���� ��
				max=n;
			}
		}
		System.out.println("�ִ밪:"+max);
		
		sc.close();
	}
}
