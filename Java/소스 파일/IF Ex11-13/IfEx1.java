package test0203;

import java.util.Scanner;

public class IfEx1 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int a,b;
		char oper; 
		
		System.out.print("�� ��?");
		a=sc.nextInt();
		b=sc.nextInt();
		
		System.out.print("������ [+,-,*,/]?");
		oper=sc.next().charAt(0);
			
		if(oper=='+') {
			System.out.printf("%d + %d = %d%n", a, b, a+b);
		} else if(oper=='-') {
	     	System.out.printf("%d - %d = %d%n", a, b, a-b);
	    } else if(oper=='*') {
	    	System.out.printf("%d * %d = %d%n", a, b, a*b);
	    } else if(oper=='/') {
	    	System.out.printf("%d / %d = %d%n", a, b, a/b);
        } else {
	    	System.out.println("������ �Է� ���� !!!");
        }	
	     	sc.close();
	}
}
