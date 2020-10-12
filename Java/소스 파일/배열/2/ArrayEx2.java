package test0207;

import java.util.Scanner;

public class ArrayEx2 {

	public static void main(String[] args) {
	/* 
	 5명의 이름과 점수를 입력 받아
	 이름 점수 편차(점수-평균)을 출력하는 프로그램 작성
	 */
		
		Scanner sc=new Scanner(System.in);
		String [] name=new String[5];
		int []score=new int[5];
		int tot, ave;
		
		tot=0;
		for(int i=0; i<name.length; i++) {
			System.out.print((i+1)+"번째 이름 : ");
			name[i] = sc.next();
			System.out.print("  점수 : ");
			score[i] = sc.nextInt();
			
			tot+=score[i]; 		// 입력 받은 점수의 합 구하기
		}
		// 평균 계산
		ave = tot / name.length;
		// 출력 
		for(int i=0; i<name.length; i++) {
			System.out.println(name[i]+"\t"+score[i]+"\t"+(score[i]-ave));
		}
		
		sc.close();
		
	}
}
