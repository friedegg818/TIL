package test0131;

import java.util.Scanner;

public class IfEx3 {
	public static void main(String[] args) {
		// ������ �Է� �޾� �Է� ���� ���� Ȧ������ �Ǻ�		
		Scanner sc=new Scanner(System.in);
		int n; 
		String s;
		
		System.out.print("���� ?");
        n=sc.nextInt();
        s="Ȧ���� �ƴ�";     // s="" �� ���� 
        if(n%2==1) {  
        	s="Ȧ��";        	
        }
                 
        System.out.println(n+":"+s);
	    sc.close();				
	}
}
