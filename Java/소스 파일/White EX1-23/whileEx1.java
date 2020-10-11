package test0203;

public class whileEx1 {
	public static void main(String[] args) {
		int n;
		
		n=0; // 초기화가 필요
		while(n<10) { // while(조건) { 조건>:true 또는 false만 가능 
			n++;
			System.out.println("안:"+n); // 10번 반복 실행 
		}
		System.out.println("밖:"+n);
	 }
}

