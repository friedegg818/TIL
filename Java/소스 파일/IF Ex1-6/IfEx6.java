package test0131;

import java.util.Scanner;

public class IfEx6 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		char ch;
		
		System.out.print("한문자?");
		ch=sc.next().charAt(0);
		
		if(ch >= 'A' && ch <= 'Z') {
			System.out.println("입력문자는 대문자");
		}
		
		if(ch >= 'a' && ch <= 'z') {
			System.out.println("입력문자는 소문자");
		}
		
		if(!(ch >= 'a' && ch <= 'z') && !(ch >= 'A' && ch <= 'Z')) {
			System.out.println("입력문자는 기타문자");
		}
		
		sc.close();
		
		// else if 문을 이용해야 함 
			
	}
}
