package test0203;

import java.util.Scanner;

public class whileEx16 {
	public static void main(String[] args) {
		//������ �Է� �޾� 1���� �Է� ���� ������ Ȧ�� �� ���ϱ� 
		Scanner sc=new Scanner(System.in);
		int num;
		int n, s;
		
		System.out.print("����?");
		num=sc.nextInt();
		
		n=1;
		s=0;
		
		while (n<=num) {   
			s+=n; 
			n+=2;			 
		}
		System.out.println("���:"+s);
			
		sc.close();		
	}
}
