package test0203;

import java.util.Scanner;
/*
 �μ� �� ������ �Է� �޾� ��Ģ����
 */

public class SwitchEx9 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		
		int n1, n2;
		String oper;
		
		System.out.print("�� ��?");
		n1=sc.nextInt();
		n2=sc.nextInt();
		System.out.print("������[+-*/]?");
		oper=sc.next();
		
		switch (oper) {
		case "+": System.out.println(n1+"+"+n2+"="+(n1+n2)); break;
		case "-": System.out.println(n1+"-"+n2+"="+(n1-n2)); break;
		case "*": System.out.println(n1+"*"+n2+"*"+(n1*n2)); break;
		case "/": System.out.println(n1+"/"+n2+"/"+(n1/n2)); break;
		}
		sc.close();		
		}		
	}
