package test0207;

import java.util.Arrays;
import java.util.Scanner;

public class ArrayTest3 {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int []num=new int[6];
		int cnt;
		
		do {
			System.out.print("구매개수[1~5]?"); 
			cnt=sc.nextInt();
		} while(cnt<1||cnt>5);			
		
		
		for(int i=1; i<=cnt; i++) {
			for(int a=0; a<num.length; a++) {
		     	num[a]=(int)(Math.random()*45)+1;
		     	for(int b=0; b<a; b++) {  // 동일숫자 제거 
		     		if(num[a]==num[b]) {
		     			a--;
		     			break;
		     		}
		     	}
		      }
		      Arrays.sort(num);
		      System.out.print(i+"번째 : ");
		      for(int n: num) {
		    	  System.out.print(n+" ");
		      }
		      System.out.println();     	 
	      }
		   
		sc.close();
		    
		}
}
