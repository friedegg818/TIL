package test0203;

import java.util.Scanner;

public class whileEx15 {
	public static void main(String[] args) {
		//������ �Է� �޾� 1���� �Է� ���� ������ �� ���ϱ� 
		Scanner sc=new Scanner(System.in);
		int num;
		int n, s;
		
		System.out.print("����?");
		num=sc.nextInt();
		
		n=0;
		s=0;
		
		while (n<num) {   // ���� �������� 1~10���� �� ���ϴ� �� ���� ���� ����
			n++;
			s+=n;  
		}
		System.out.println("���:"+s);
			
		sc.close();		
	}
}
