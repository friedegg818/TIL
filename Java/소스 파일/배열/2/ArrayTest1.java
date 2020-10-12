package test0207;

import java.util.Scanner;

public class ArrayTest1 {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
			
		String [] ani = {"¿ø¼şÀÌ","´ß","°³","µÅÁö","Áã","¼Ò","¹ü","Åä³¢","¿ë","¹ì","¸»","¾ç"};
	
		int y;
		
		do {
			System.out.print("³âµµ?");
			y=sc.nextInt();
		} while (y<1900);
				
		System.out.println(y+"³âµµ´Â "+ani[y%12]+"¶ì ÀÇ ÇØÀÔ´Ï´Ù.");
		
		/*		 
		 y%12 
		 ani[0] ¿ø¼şÀÌ 		 
		 */		
		
		sc.close();
	}
}
