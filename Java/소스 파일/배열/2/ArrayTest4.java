package test0207;

import java.util.Scanner;

public class ArrayTest4 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		
		int[] month={31,0,31,30,31,30,31,31,30,31,30,31};
		
		String[] week={"��", "��", "ȭ", "��", "��", "��", "��"};
		
		int y,m;
		
		do {
			System.out.print("�⵵?");
			y=sc.nextInt();
		} while (y<1900);
		
		do {
			System.out.print("��?");
			m=sc.nextInt();
		} while (m<1||m>12);
			
		//2�� 
		if(y%4==0&&y%100!=0||y%400==0)
			month[1]=29;
		else 
			month[1]=28;


		int tot;
		tot = (y-1)*365 + ((y-1)/4 - (y-1)/100 + (y-1)/400); 
		for(int i=0; i<m-1; i++) {
		tot+=month[i];    
		}
		tot++;  // m�� 1�ϱ����� ��ü ��¥ 
		
		// week[tot%7] <- ���� 
		
		System.out.println();
					
		System.out.println(y+"�� "+m+"��");						
				
		for(String n:week) {
			System.out.printf("%s\t",n);
		}
		System.out.println();
		System.out.println("===================================================");
		
		int cnt=0;
		for(int i=1; i<=tot%7; i++) {
			 System.out.print("\t"); // ���� 			 
			 cnt++; 
		}				
		
		for(int j=1; j<=month[m-1];j++) {
			System.out.print(j+"\t");
			cnt++;
			if(cnt%7==0) { 
				System.out.println();
			}
		}
	
	 sc.close();	
		
	}
}
