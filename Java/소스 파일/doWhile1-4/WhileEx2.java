package test0204;

import java.util.Scanner;

// ���� �Է� �޾� ������ ���. ��, �Է� ���� ���� 1~9�� ����� ���Է�.
public class WhileEx2 {

	public static void main(String[] args) {
		int dan, n;
		Scanner sc=new Scanner(System.in);
		
		do {
			System.out.print("��?");
			dan=sc.nextInt();
		} while(dan<1 || dan>9);
			
		n=0;
		while(n<9) {
			n++;
			System.out.printf("%d*%d=%d%n",dan,n,dan*n);
		}
			sc.close();		
	}
}
