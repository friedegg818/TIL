package test0131;

import java.util.Scanner;

public class IfEx5 {
	public static void main(String[] args) {
		// �� ���� �Է� �޾� ���������� ū�� ������ ���(������ ����) 
		Scanner sc=new Scanner(System.in);
		int a,b,c, t;
		
		System.out.print("�� ��?");
		a=sc.nextInt();
		b=sc.nextInt();
		c=sc.nextInt();
		
		if(a > b) {
			t=a; a=b; b=t;
		}
			// �����ϰ� ���� a<b		
		if(a > c) {
			t=a; a=c; c=t;
		}
		    // �����ϰ� ���� a<c -> a�� ���� ���� �� 
		if(b > c) {
			t=b; b=c; c=t;
		}
		   // �����ϰ� ���� b<c -> a<b<c�� ��. 
		
		System.out.println(a+","+b+","+c);		
		
		sc.close();		
	}
}
