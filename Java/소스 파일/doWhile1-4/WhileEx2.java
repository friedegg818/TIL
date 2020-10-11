package test0204;

import java.util.Scanner;

// 단을 입력 받아 구구단 출력. 단, 입력 받은 단이 1~9를 벗어나면 재입력.
public class WhileEx2 {

	public static void main(String[] args) {
		int dan, n;
		Scanner sc=new Scanner(System.in);
		
		do {
			System.out.print("단?");
			dan=sc.nextInt();
		} while(dan<1 || dan>9);
			
		n=0;
		while(n<9) {
			n++;
			System.out.printf("%d*%d=%d%n",dan,n,dan*n);
		}
			sc.close();		
	}
}
