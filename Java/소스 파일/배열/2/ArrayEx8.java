package test0207;

import java.util.Scanner;

public class ArrayEx8 {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int[] month={31,0,31,30,31,30,31,31,30,31,30,31};
					// month[0] ~ month[11] 
		String[] week={"��", "��", "ȭ", "��", "��", "��", "��"};
		int y, m, d; 
		
		do {
			System.out.print("�⵵?");
			y=sc.nextInt();
		} while(y<0); 
		
		do {
			System.out.print("��?");
			m=sc.nextInt();
		} while(m<1||m>12); 
		
		// 2�� ���� ��� 
		if(y%4==0&&y%100!=0||y%400==0)
			month[1]=29;
		else 
			month[1]=28;
		
		do {
			System.out.print("��?");
			d=sc.nextInt();
		} while(d<1||d>month[m-1]); 
				
		// 1�� 1�� 1���� ������ 
		// ��ü ���� ����ϱ� 
		
		int tot;
		tot = (y-1)*365 + ((y-1)/4 - (y-1)/100 + (y-1)/400); 
		for(int i=0; i<m-1; i++) {
			tot+=month[i];     // m-1�������� ������ ���ؾ��ϹǷ� 
							   // m-1���� ���� month[m-2]�� ������ ���� 
		}
		tot+=d; 
		
		System.out.printf("%d�� %d�� %d���� %s����\n", y,m,d,week[tot%7]);
		
		/* 2020�� 4�� 20��? 
		 1.1.1 ~ 2019.12.31
		  ��ü���� = 2019 * 365 + (2019/4 - 2019/100 + 2019/400); 
		  ��ü���� += 1��, 2��, 3�� 
		  ��ü���� += 20 
		 */		
		
		sc.close();	
		}
}
