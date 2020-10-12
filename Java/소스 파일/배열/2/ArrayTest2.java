package test0207;

import java.util.Scanner;

public class ArrayTest2 {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int [] score=new int[5];
		int max, min, tot;
		
		tot=0;
		for(int i=0;i<5;i++) {
			do {
				System.out.print((i+1)+"번째 점수 : ");
				score[i] = sc.nextInt();
				// tot+=score[i]; <- 이곳에 적으면 잘못 입력된 점수도 합해지므로 X
			} while (score[i]<0||score[i]>10); 
			  tot+=score[i]; 
		}
				
		max=min=score[0]; // 최대, 최소값에 초기값 부여 
		for(int i=1; i<5; i++) {
			if(max < score[i])
				max=score[i];
			else if(min > score[i])  // max와 min에 초기값을 주었기 때문에 else if도 가능 
				min=score[i];
	    }		
		
		for(int n : score) {
			System.out.print(n+" ");
		}
		
		System.out.println();
		
		System.out.println(tot-max-min);
		
		
		sc.close();
	}
}
