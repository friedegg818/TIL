package test0205;

import java.util.Scanner;

public class whilequiz6 {

		public static void main(String[] args) {
			Scanner sc=new Scanner(System.in);
			int com, user, cnt;
			
			// 1~100 ���� ���� �߻� 
			com = (int)(Math.random()*100)+1;
			
			// ī��Ʈ ���� �ʱ�ȭ 
			cnt=0;
			while(true) { // ���� ���� 
				System.out.println("��?");
				user=sc.nextInt();
				cnt++;
				
				if(com>user) {
					System.out.println("�Է��� ������ �� Ů�ϴ�.");
				} else if(com<user) {
					System.out.println("�Է��� ������ �� ���� �� �Դϴ�.");
				} else {
					System.out.println(cnt+"���� �����߽��ϴ�."); 
					break; // ������ ���� ������ �������� 
				}
			}
			
			sc.close();
		}
}