package test0131;

import java.util.Scanner;

public class IfEx6 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		char ch;
		
		System.out.print("�ѹ���?");
		ch=sc.next().charAt(0);
		
		if(ch >= 'A' && ch <= 'Z') {
			System.out.println("�Է¹��ڴ� �빮��");
		}
		
		if(ch >= 'a' && ch <= 'z') {
			System.out.println("�Է¹��ڴ� �ҹ���");
		}
		
		if(!(ch >= 'a' && ch <= 'z') && !(ch >= 'A' && ch <= 'Z')) {
			System.out.println("�Է¹��ڴ� ��Ÿ����");
		}
		
		sc.close();
		
		// else if ���� �̿��ؾ� �� 
			
	}
}
