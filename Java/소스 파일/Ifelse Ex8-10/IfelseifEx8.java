package test0131;

import java.util.Scanner;

public class IfelseifEx8 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int n;
		
		System.out.print("정수?");
		n=sc.nextInt();
		
		if(n%2==0 && n%3==0) {   //  if(n%6==0)  {
			System.out.println(n+" : 2 와 3의 배수");
		} else if(n%2==0) {
			System.out.println(n+" : 2의 배수");
		} else if(n%3==0) {
			System.out.println(n+" : 3의 배수");
		} else {
			System.out.println(n+" : 2 또는 3의 배수가 아님");
		}
		
		// if 문의  순서를 바꿔도 되지만, 바꾸면 안되는 경우도 있다.
		
		sc.close();
	}
}
