package test0203;

import java.util.Scanner;
/*
 �⵵�� ���� �Է� �޾� ���� ������ ��¥ ��� 
 */
public class SwitchEx10 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int y,m,d;
		
		System.out.print("�⵵?");
		y=sc.nextInt();
		System.out.print("��?");
		m=sc.nextInt();
		
		// 2�� : �⵵�� 4�� ����̰� 100�� ����� �ƴϰų� 400�� ����̸� 29��,
		//      �׷��� ������ 28�� 
		switch(m) {
		case 1: case 3: case 5: case 7: case 8: case 10: case 12:
			d = 31; break;
		case 4: case 6: case 9: case 11: 
			d = 30; break;
		case 2: 
			if(y%4==0 && y%100!=0 || y%400==0) {
				d=29; 
			} else { 
				d=28;
			}
			break;
		default: d=0; break; // ������ ���ֱ� ���� d�� �ʱⰪ �ο� 
		}
		
		if(d!=0) {
			System.out.println(y+"�� "+m+"�� ������ ��¥�� "+d+"�� �Դϴ�.");
		} else {
			System.out.println("�Է� ����...");
		
		sc.close();
}     }
	}