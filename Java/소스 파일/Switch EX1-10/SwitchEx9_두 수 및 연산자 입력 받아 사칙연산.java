package test0203;

import java.util.Scanner;
/*
 두수 및 연산자 입력 받아 사칙연산
 */

public class SwitchEx9 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		
		int n1, n2;
		String oper;
		
		System.out.print("두 수?");
		n1=sc.nextInt();
		n2=sc.nextInt();
		System.out.print("연산자[+-*/]?");
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
