package test0131;

import java.util.Scanner;

public class IfTest6 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int t; 
		
		System.out.print("�ٹ��ð�?");
		t=sc.nextInt();
		
		if (t>0 && t<=8) {
			System.out.printf("�޿� : "+"%,d%n" ,t*10000);
		} else if (t>8) {
	     	System.out.printf("�޿� : "+ "%,d%n", (t-8)*15000+80000);
		}	
		
		sc.close();
		
		/* 
		 int h, pay;
		 
		 System.out.print("�ٹ��ð�?");
		 h = sc.nextInt();
		 
		 if (h>8) {
		     pay = 8*10000 + (int)((h-8)*10000*1.5);		 
		 } else {
		     pay = h*10000; 
		 }
		 
		 System.out.printf("�޿� : %,d\n", pay);
		 
		 sc.clsoe();
		 
		 */
		}
}
