package test0131;

import java.util.Scanner;

public class IfTest5 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int a;
		
		System.out.print("����?");
		a=sc.nextInt();
		
		if(a>=0 && a<=100) {          // ���� �Է��� �ùٸ� ��� 
		   if(a>=95) {
			   System.out.println("���� : "+a+"���� : 4.5");
			} else if(a>=90) {
				   System.out.println("���� : "+a+"���� : 4.0");
			} else if(a>=85) {
				   System.out.println("���� : "+a+"���� : 3.5");
			} else if(a>=80) {			
				   System.out.println("���� : "+a+"���� : 3.0");
			} else if(a>=75) {
				   System.out.println("���� : "+a+"���� : 2.5");
			} else if(a>=70) {
				   System.out.println("���� : "+a+"���� : 2.0");
			} else if(a>=65) {
				   System.out.println("���� : "+a+"���� : 1.5");
			} else if(a>=60) {
				   System.out.println("���� : "+a+"���� : 1.0");
			} else {
				   System.out.println("���� : "+a+"���� : 0.0");
			}
		   
		} else {
			System.out.println("�Է¿���");
		}
		
		sc.close(); 
	}
}
