package test0203;

public class whileEx5 {
	public static void main(String[] args) {
		int n;
		
		n=0; 
		while(n++ < 10) { 
			System.out.println("안:"+n); // 1 2 3 4 5 6 7 8 9 10
		}	
		System.out.println("밖:"+n); // 11
	 }
	}

/*
 n=0 
 n<10 → n++(1)
 System.out.println("안:"+1);

 n=1
 n<10 → n++(2)
 System.out.println("안:"+2);
 .
 .
 n=8
 n<10 → n++(9)
 System.out.println("안:"+9);
 
 n=9
 n<10 → n++(10)
 System.out.println("안:"+10);
 
 n<10 : false, n++(11)
 System.out.println("밖:"+11);
 */

