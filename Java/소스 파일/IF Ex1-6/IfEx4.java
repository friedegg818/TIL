package test0131;

import java.util.Scanner;

public class IfEx4 {
	public static void main(String[] args) {
		// 정수를 입력 받아 입력 받은 수가 짝수인지 홀수인지 판별		
		Scanner sc=new Scanner(System.in);
		int n; 
		String s;
		
		System.out.print("정수 ?");
        n=sc.nextInt();
        
        // s=n%2==1 ? "홀수":"짝수";ㅣ
        
        s="짝수";    
        if(n%2==1) {  
        	s="홀수";        	
        }
                 
        System.out.println(n+":"+s);
	    sc.close();				
	}
}
