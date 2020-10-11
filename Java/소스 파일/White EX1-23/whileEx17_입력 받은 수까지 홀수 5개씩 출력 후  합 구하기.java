package test0203;

import java.util.Scanner;

public class whileEx17 {
	public static void main(String[] args) {
		//정수를 입력 받아 1부터 입력 받은 수까지 홀수를 
		//한 줄에 5개씩 출력하고 마지막에  합 구하기    
		Scanner sc=new Scanner(System.in);
		int num;
		int n, s, cnt;
		
		System.out.print("정수?");
		num=sc.nextInt();
		
		n=1;
		s=0;
		cnt=0;
		
		while (n<=num) {   
			s+=n; 
			System.out.print(n+"\t");   
			// n : 홀수 만들기, s: 합 구하기 > n or s는 건드리면 안 됨 > 새로운 변수 필요 
			cnt++;  // 홀수 출력 개수 카운트 
			if(cnt%5==0) // 한줄에 5개 출력했으면 라인 넘기기 
				System.out.println();
			
			n+=2; // 홀수 만들기  
		}
	    if(cnt%5!=0)
			System.out.println(); 
		
		System.out.println("결과:"+s);  //  "\n결과:" 로 하면 5로 떨어질 경우 한 줄 더 띄워짐 
			
		sc.close();		
	}
}
