package test0207;

import java.util.Scanner;

public class ArrayTest1 {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
			
		String [] ani = {"������","��","��","����","��","��","��","�䳢","��","��","��","��"};
	
		int y;
		
		do {
			System.out.print("�⵵?");
			y=sc.nextInt();
		} while (y<1900);
				
		System.out.println(y+"�⵵�� "+ani[y%12]+"�� �� ���Դϴ�.");
		
		/*		 
		 y%12 
		 ani[0] ������ 		 
		 */		
		
		sc.close();
	}
}
