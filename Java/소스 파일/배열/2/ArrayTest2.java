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
				System.out.print((i+1)+"��° ���� : ");
				score[i] = sc.nextInt();
				// tot+=score[i]; <- �̰��� ������ �߸� �Էµ� ������ �������Ƿ� X
			} while (score[i]<0||score[i]>10); 
			  tot+=score[i]; 
		}
				
		max=min=score[0]; // �ִ�, �ּҰ��� �ʱⰪ �ο� 
		for(int i=1; i<5; i++) {
			if(max < score[i])
				max=score[i];
			else if(min > score[i])  // max�� min�� �ʱⰪ�� �־��� ������ else if�� ���� 
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
