package test0203;

import java.util.Scanner;

public class whileEx17 {
	public static void main(String[] args) {
		//������ �Է� �޾� 1���� �Է� ���� ������ Ȧ���� 
		//�� �ٿ� 5���� ����ϰ� ��������  �� ���ϱ�    
		Scanner sc=new Scanner(System.in);
		int num;
		int n, s, cnt;
		
		System.out.print("����?");
		num=sc.nextInt();
		
		n=1;
		s=0;
		cnt=0;
		
		while (n<=num) {   
			s+=n; 
			System.out.print(n+"\t");   
			// n : Ȧ�� �����, s: �� ���ϱ� > n or s�� �ǵ帮�� �� �� > ���ο� ���� �ʿ� 
			cnt++;  // Ȧ�� ��� ���� ī��Ʈ 
			if(cnt%5==0) // ���ٿ� 5�� ��������� ���� �ѱ�� 
				System.out.println();
			
			n+=2; // Ȧ�� �����  
		}
	    if(cnt%5!=0)
			System.out.println(); 
		
		System.out.println("���:"+s);  //  "\n���:" �� �ϸ� 5�� ������ ��� �� �� �� ����� 
			
		sc.close();		
	}
}
