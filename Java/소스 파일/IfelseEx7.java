package test0131;

import java.util.Scanner;

public class IfelseEx7 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int n;
		String s;
		
		System.out.print("Á¤¼ö?");
		n=sc.nextInt();
		
		if(n%2==0) {
			s="Â¦¼ö";
		} else     {
			s="È¦¼ö";
		}
	    System.out.println(n+":"+s);
	    
	    sc.close();
	}
}
