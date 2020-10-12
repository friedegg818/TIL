package test0207;

import java.util.Scanner;

public class ArrayTest1 {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
			
		String [] ani = {"원숭이","닭","개","돼지","쥐","소","범","토끼","용","뱀","말","양"};
	
		int y;
		
		do {
			System.out.print("년도?");
			y=sc.nextInt();
		} while (y<1900);
				
		System.out.println(y+"년도는 "+ani[y%12]+"띠 의 해입니다.");
		
		/*		 
		 y%12 
		 ani[0] 원숭이 		 
		 */		
		
		sc.close();
	}
}
