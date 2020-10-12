package test0204;

public class ForEx4 {
	public static void main(String[] args) {
		/* 1~100까지 합 구하기 
		int s=0; 
		
		for(int n=1; n<=100; n++) {
			s+=n;
		}
		System.out.println("결과:"+s); */
		
		/* 1~100까지 홀수 합 구하기 
		 int s=0; 		
		 
		for(int n=1; n<=100; n+=2) {
			s+=n;
		}
		System.out.println("홀수합:"+s); */
		
		/* 1~100까지 홀수 합 구하기 
		int s, n;
		for(n=2, s=0; n<=100; n+=2) { // 초기값에서 , 찍고 초기값 가능 (증감식도 가능)
			s+=n;
		}
		System.out.println("짝수합:"+s); */
		
		int s, n;
		for(n=1, s=0; n<=100; s+=n, n++) // 권하지 않는 방식 
			;
		System.out.println("합:"+s);
		
	}	
}
