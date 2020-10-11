package test0131;

import java.util.Scanner;

public class IfTest5 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int a;
		
		System.out.print("점수?");
		a=sc.nextInt();
		
		if(a>=0 && a<=100) {          // 점수 입력이 올바른 경우 
		   if(a>=95) {
			   System.out.println("점수 : "+a+"평점 : 4.5");
			} else if(a>=90) {
				   System.out.println("점수 : "+a+"평점 : 4.0");
			} else if(a>=85) {
				   System.out.println("점수 : "+a+"평점 : 3.5");
			} else if(a>=80) {			
				   System.out.println("점수 : "+a+"평점 : 3.0");
			} else if(a>=75) {
				   System.out.println("점수 : "+a+"평점 : 2.5");
			} else if(a>=70) {
				   System.out.println("점수 : "+a+"평점 : 2.0");
			} else if(a>=65) {
				   System.out.println("점수 : "+a+"평점 : 1.5");
			} else if(a>=60) {
				   System.out.println("점수 : "+a+"평점 : 1.0");
			} else {
				   System.out.println("점수 : "+a+"평점 : 0.0");
			}
		   
		} else {
			System.out.println("입력오류");
		}
		
		sc.close(); 
	}
}
