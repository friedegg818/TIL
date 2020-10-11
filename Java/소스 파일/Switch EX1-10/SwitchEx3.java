package test0203;

import java.util.Scanner;

public class SwitchEx3 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int a;
		
		System.out.print("Á¤¼ö?");
		a=sc.nextInt();

		/*
		switch(a) {
		case 3:System.out.print("*");
		case 2:System.out.print("*");
		case 1:System.out.print("*");
		}
		*/
		
		switch(a) {
		case 3:System.out.println("***"); break;
		case 2:System.out.println("**"); break;
		case 1:System.out.println("*"); break;
		}
		
		sc.close();		
	}
}
