package test0131;

import java.util.Scanner;

public class IfelseifEx9 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int n;
		
		System.out.print("점수?");
		n=sc.nextInt();
		
		if(n>=90)  {
			System.out.println(n+": 수");
		} else if(n>=80) {   // } else if(n>=80 && n<90)  {
			System.out.println(n+": 우");
		} else if(n>=70) {
			System.out.println(n+": 미");
		} else if(n>=60) {
			System.out.println(n+": 양");
		} else {
			System.out.println(n+": 가");
		}
		
		sc.close();		
	}
}
