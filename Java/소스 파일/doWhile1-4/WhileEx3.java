package test0204;

import java.util.Scanner;

// ���� �Է� �޾� ������ ���. ��, �Է� ���� ���� 1~9�� ����� ���Է�.
public class WhileEx3 {

	public static void main(String[] args) {
		int dan=0, n;
		boolean b;
		Scanner sc=new Scanner(System.in);
		
		// do~while������ �ۼ��ϴ� ���� �� ȿ������ 
		b=true;
		while(b) {
			System.out.print("��?");
			dan=sc.nextInt();
			if(dan>=1 && dan<=9)
				b=false;
		} 
			
		n=0;
		while(n<9) {
			n++;
			System.out.printf("%d*%d=%d%n",dan,n,dan*n);
		}
			sc.close();		
	}
}
