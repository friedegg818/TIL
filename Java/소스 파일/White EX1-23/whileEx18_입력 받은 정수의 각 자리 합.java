package test0203;

import java.util.Scanner;

public class whileEx18 {
	public static void main(String[] args) {
		// ������ �Է� �޾� �Է� ���� ������ �� �ڸ��� ���� ���ϱ� 
		Scanner sc=new Scanner(System.in);
		int n, s;
		n=0; // �ʱ�ȭ. but �� ���� �ʾƵ� ��. ��� �ַ��� �Է� ���� ��� �� 
		s=0;
		
		System.out.print("���ڸ� �Է��ϼ���."); 
		n=sc.nextInt();
			
		while (n!=0) {
			s += n%10; // s�� n�� 10���� ���� �������� ���ϱ� 
			           // � ���ڸ� 10���� ������ �� ���ڸ� ���� ����
		System.out.printf("sum=%3d num=%d%n", s,n);
		               // %3d > ������ 3�ڸ��� ǥ�� 
		
		n /= 10; // n�� 10���� ���� ���� �ٽ� n�� �ο�  
		         // (=������ �ڸ� �� ���� ���� ��) 
	}
		System.out.println("�� �ڸ����� ��:"+s);
		
		sc.close();		
	}
}
