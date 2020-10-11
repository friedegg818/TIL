package test0131;

import java.util.Scanner;

public class Test_Scanner {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		
		System.out.print("문자열?");
		String s=sc.next(); // sc.next() <- 문자열을 입력받는 기능
		
		char ch;
		
		ch = s.charAt(0); // 0 -> 가장 처음에 위치해있는 글자
            // charAt() : 문자열에서 특정 위치에 있는 하나만 가져옴
		System.out.println(ch);
		
		ch = s.charAt(2); // 2 -> 세번째 위치해있는 글자 
		System.out.println(ch);
		
		sc.close();
	}
}
