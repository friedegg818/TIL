package test0204;

public class ForEx5 {
	public static void main(String[] args) {
		
	/* int n;
		for(n=10; n<=1; n++) { // 조건을 만족하지 않으면 한 번도 실행 안 함 
			System.out.println("안:"+n);
		}
		System.out.println("밖:"+n); // 10  
											*/
		
		int n;
		for(n=10; n>=1; n--) {
			System.out.println("안:"+n); // 10 9 ... 2 1
		}
		System.out.println("밖:"+n); // 0 
	}
}
