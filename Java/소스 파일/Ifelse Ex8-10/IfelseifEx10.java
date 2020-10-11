package test0131;

import java.util.Scanner;

public class IfelseifEx10 {    // IfEx6 예제 
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		char ch;
		// if ~ else if 로 코딩하는 것이 더 효율적 
		
		System.out.print("문자?");
		ch=sc.next().charAt(0);
		
		if(ch>='A'&&ch<='Z') {
			System.out.println(ch+" : 대문자");
		} else if (ch>='a'&&ch<='z') {
			System.out.println(ch+" : 소문자");
		} else {
			System.out.println(ch+" : 기타문자");
		}
		
		sc.close();
	}
}
