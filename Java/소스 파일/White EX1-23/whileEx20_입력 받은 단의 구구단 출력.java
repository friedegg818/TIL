package test0203;

import java.util.Scanner;

public class whileEx20 {
	public static void main(String[] args) {
		//���� �Է� �޾� �Է� ���� ���� ������ ��� 
		Scanner sc=new Scanner(System.in);
		int dan, n; 
		
		System.out.print("��[1-9]?");
		dan=sc.nextInt();
		
		n=0;
		while (n<9) {
			n++; 
			System.out.printf("%d*%d=%d\n", dan,n,dan*n);
		}
		sc.close();
	}
}
