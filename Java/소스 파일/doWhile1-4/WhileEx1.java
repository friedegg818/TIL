package test0204;

public class WhileEx1 {
	
	public static void main(String[] args) {
/*
		int n=0;
		
		do {
			n++;
			System.out.println("안:"+n);
		} while(n<10);
		System.out.println("밖:"+n);
*/
/*	
		int n, s;
		n=s=0;
		
		do {
			n++;
			s+=n;
		} while(n<10);
		System.out.println("결과:"+s);
*/
		int n=10;
		while(n<10) { // 처음 조건을 만족하지 않으면 한번도 실행 X (첫 조건이 중요)
			n++;
			System.out.println("while 안:"+n);
		}
		System.out.println("while 밖:"+n);
		
		n=10;
		do { // 적어도 한번은 실행 
			n++;
			System.out.println("do~while 안:"+n);
		} while(n<10);
		System.out.println("do~while 밖:"+n);
	
	}
}
