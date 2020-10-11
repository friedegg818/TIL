package test0131;

import java.util.Scanner;

public class IfEx3 {
	public static void main(String[] args) {
		// 정수를 입력 받아 입력 받은 수가 홀수인지 판별		
		Scanner sc=new Scanner(System.in);
		int n; 
		String s;
		
		System.out.print("정수 ?");
        n=sc.nextInt();
        s="홀수가 아님";     // s="" 도 가능 
        if(n%2==1) {  
        	s="홀수";        	
        }
                 
        System.out.println(n+":"+s);
	    sc.close();				
	}
}
