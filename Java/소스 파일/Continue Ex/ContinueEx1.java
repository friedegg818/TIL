package test0206;

import java.util.Scanner;

public class ContinueEx1 {

	public static void main(String[] args) {
		// 5���� Ȧ���� �Է� �޾� �Է� ���� Ȧ���� �� ���ϱ� 
		// ��, �Է� ���� ���� 0���� ���ų� ¦���̸� �ٽ� �Է� �ޱ� 
		
		Scanner sc=new Scanner(System.in);
		int s,n;
		
		System.out.println("0�̻��� 5�� Ȧ�� �Է�...");
		
		s=0;
		for(int i=1; i<=5; i++) {
			n=sc.nextInt(); 
			if(n<0 || n%2==0) {
				i--;   // ¦���� �Է����������� �Է��� ���� ī��Ʈ ���ؾ��ϹǷ�
				continue;
			}			
			s+=n;
		}			
		System.out.println("���:"+s);
		sc.close();			
	}
}
