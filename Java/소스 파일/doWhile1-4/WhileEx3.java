package test0204;

import java.util.Scanner;

// 단을 입력 받아 구구단 출력. 단, 입력 받은 단이 1~9를 벗어나면 재입력.
public class WhileEx3 {

	public static void main(String[] args) {
		int dan=0, n;
		boolean b;
		Scanner sc=new Scanner(System.in);
		
		// do~while문으로 작성하는 것이 더 효율적임 
		b=true;
		while(b) {
			System.out.print("단?");
			dan=sc.nextInt();
			if(dan>=1 && dan<=9)
				b=false;
		} 
			
		n=0;
		while(n<9) {
			n++;
			System.out.printf("%d*%d=%d%n",dan,n,dan*n);
		}
			sc.close();		
	}
}
