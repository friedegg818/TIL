package test0204;

public class ForEx8 {
	public static void main(String[] args) {
		// 1~100까지 수 중 3 또는 5의 배수를 한줄에 5개씩 출력하고 
		// 마지막에 합과 평균 출력 
		
		int cnt=0;
		int s=0;
		for(int n=1; n<=100; n++) {
			if(n%3==0 || n%5==0) {
				System.out.printf("%5d",n); // 자리수 맞추기 위해 printf 사용
				s+=n;
				if(++cnt%5==0) {
				System.out.println();
				}
			}
		} 
		  System.out.println("\n합:"+s); // 라인 내려주기 위해 \n
		  System.out.printf("평균:%d%n", s/cnt);
	}
}
